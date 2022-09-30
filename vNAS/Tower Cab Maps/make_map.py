import json
import sys
from tkinter.filedialog import askopenfilename
import xml.etree.ElementTree as ET


styles = {
	# (color, zIndex)
	"whitepaint": ("#ffffff", 6),
	"yellowpaint": ("#fff56e", 5),
	"structure": ("#808080", 4),
	"apron": ("#d1d1d1", 3),
	"runway": ("#545454", 2),
	"taxiway": ("#a6a6a6", 1)
}

ns = {
	"": "http://www.opengis.net/kml/2.2"
}


def parseCoordinates(text):
	''' Convert from kml coordinates to GeoJSON coordinates '''
	coords = []
	for pt in text.strip().split(" "):
		lon = float(pt.split(",")[0])
		lat = float(pt.split(",")[1])
		coords.append([lon, lat])
	return coords


def makeLineString(placemark) -> list:
	coordinates = placemark.find(".//coordinates", ns).text
	return parseCoordinates(coordinates)


def makePolygon(placemarks: list) -> list:
	result = []
	for p in placemarks:
		coordinates = p.find(".//coordinates", ns).text
		linearRing = parseCoordinates(coordinates)
		result.append(linearRing)
	return result


# Get map kml file
filename = askopenfilename(
	title="Select Tower Cab Map file",
	filetypes=[("KML files","*.kml")],
	initialdir="."
	)
if filename == "":
	sys.exit()
root = ET.parse(filename).getroot()

# Get the airport's FAA 3LD
faaID = root.find("./Document/Folder/name", ns).text

# Start parsin'
features = []
for folder in root.findall("Document/Folder/Folder", ns):
	color, zIndex = styles[folder.find("name", ns).text]
	lineStrings = []
	polygons = []
	placemarkQueue = []
	makeInnerRings = False
	for placemark in folder.findall("Placemark", ns):
		if placemark.find("LineString", ns):
			# Add to MultiLineString
			lineStrings.append(makeLineString(placemark))
		elif placemark.find("Polygon", ns):
			# Add to MultiPolygon
			name = placemark.find("name", ns).text
			if name == "outer":
				makeInnerRings = True
				placemarkQueue.append(placemark)
			elif name == "inner" and makeInnerRings:
				placemarkQueue.append(placemark)
			elif name != "inner" and makeInnerRings:
				makeInnerRings = False
				polygons.append(makePolygon(placemarkQueue))
				polygons.append(makePolygon([placemark]))
				placemarkQueue = []
			else:
				polygons.append(makePolygon([placemark]))
	# Handle the case where the last item is an "inner"
	if len(placemarkQueue) > 0:
		polygons.append(makePolygon(placemarkQueue))
	if len(lineStrings) > 0:
		feature = {
			"type": "Feature",
			"geometry": {
				"type": "MultiLineString",
				"coordinates": lineStrings
			},
			"properties": {
				"color": color,
				"thickness": 1,
				"style": "solid",
				"zIndex": zIndex
			}
		}
		features.append(feature)
	if len(polygons) > 0:
		feature = {
			"type": "Feature",
			"geometry": {
				"type": "MultiPolygon",
				"coordinates": polygons
			},
			"properties": {
				"color": color,
				"zIndex": zIndex
			}
		}
		features.append(feature)

# Output
final = {
	"type": "FeatureCollection",
	"features": features
}
with open(filename[:-3]+"geojson", "w") as file:
	json.dump(final, file, indent=2)

print("Complete!")
input("Press ENTER to continue . . . ")