# Parses and generates a sct2 APD from a KML file
# 
# This structure must exist for gen_apd to find the kml file (for example)
# ...
# -gen_apd.py
# -KPDX
#	|_KPDX.kml
# ...

import sys
import xml.dom.minidom as xml # xml parser

# Removes whitespace, unwanted "0"s and rearranges to "lat lon"
def cleanCoords(coord_str):
	result = []
	# Remove whitespace, split into pairs
	coord_arr = coord_str.strip("\t")
	coord_arr = coord_arr.split()
	for group in coord_arr:
		group = group.split(",")
		result.append((group[1], group[0]))
	return result

# Converts decimal degrees to Xddd.mm.ss.sss
def ddToDMS(lat, lon):
	# Get NESW
	ns = "N" if lat >= 0 else "S"
	ew = "E" if lon >= 0 else "W"
	# Make positive
	lat = abs(lat)
	lon = abs(lon)
	# Floor to get degrees
	latd = int(lat)
	lond = int(lon)
	# Get minutes
	latm = 60*(lat - latd)
	lonm = 60*(lon - lond)
	# Get seconds
	lats = 60*(latm - int(latm))
	lons = 60*(lonm - int(lonm))
	# Assemble the strings
	lat_out = "%s%03.f.%02.f.%06.3f" % (ns, latd, int(latm), lats)
	lon_out = "%s%03.f.%02.f.%06.3f" % (ew, lond, int(lonm), lons)
	return lat_out + " " + lon_out

# Gets the corresponding color for the KML shorthands/groups
def getActualColor(alias):
	colors = {
		"blastpad": "blastpad",
		"building": "building",
		"displacedthreshold": "runway",
		"helipad": "helipad",
		"holdshort": "HoldShort",
		"movementarea": "NonMovementAreaBoundary",
		"ramp": "ramp",
		"runway": "runway",
		"taxiway": "taxiway",
		"twyrwy_labels": "twyrwy_labels",
		"building_labels": "building_labels",
		"ramp_labels": "ramp_labels",
		"ils": "ILSHoldShort",
		"oldtaxiway": "taxiOld",
		"lawngreen": "Lime",
		"taxilane": "taxilane",
		"taxilane_labels": "taxilane_labels"
	}
	if alias not in colors:
		raise Exception("Unknown color alias " + alias)
	else:
		return colors[alias]

airport = input("Airport: ")
# Input (kml)
inf = open("%s/%s.kml" % (airport, airport), "r")
root = xml.parseString(inf.read())
inf.close()
# Paths output
paths_f = open(airport + "/apd.txt", "w")
paths_f.write("    ; APD: %s\n" % airport)
# Labels output
labels_f = open(airport + "/labels.txt", "w")
labels_f.write("; %s Labels\n" % airport)
# Begin parsing!
placemarks = root.getElementsByTagName("Placemark")
for mark in placemarks:
	# Get containing folder
	parent = mark.parentNode
	# Get the shorthand/group that's used in G Earth
	group = parent.getElementsByTagName("name")[0].firstChild.nodeValue
	# Find the VRC color associated with the group
	color = getActualColor(group)

	# Get coordinates
	coords = mark.getElementsByTagName("coordinates")[0].firstChild.nodeValue
	# Clean up coordinates
	coords = cleanCoords(coords)

	# Figure out if label (only labels have <Point> tags)
	islabel = len(mark.getElementsByTagName("Point")) != 0
	if islabel:
		# Label handling
		# Get label text
		text = mark.getElementsByTagName("name")[0].firstChild.nodeValue
		# Get lat and lon
		lat = float(coords[0][0])
		lon = float(coords[0][1])
		
		labels_f.write("\"%s\" %s %s\n" % (text, ddToDMS(lat, lon), color))
		print(text)
	else:
		# Path handling
		if len(coords) <= 1:
			# If it's just a single point, skip it
			continue

		for i in range(len(coords)):
			c = coords[i]

			# Get lat and lon
			lat = float(c[0])
			lon = float(c[1])

			if i == 0:
				# If first in chain, start a new segment
				paths_f.write(" "*26 + ddToDMS(lat, lon))
			elif i == len(coords)-1:
				# If last in chain, end the segment
				paths_f.write(" %s %s\n" % (ddToDMS(lat, lon), color))
			else:
				# If in the middle, end segment and start a new one
				paths_f.write(" %s %s\n" % (ddToDMS(lat, lon), color))
				paths_f.write(" "*26 + ddToDMS(lat, lon))
			print(ddToDMS(lat, lon))

paths_f.close()
labels_f.close()
print("*Completed*")
