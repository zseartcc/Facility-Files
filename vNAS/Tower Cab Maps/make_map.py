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

ns = {"": "http://www.opengis.net/kml/2.2"}


def parseCoordinates(text: str) -> list:
	''' Convert from kml coordinates to GeoJSON coordinates '''
	coords = []
	for pt in text.strip().split(" "):
		lon, lat, _ = pt.split(",")
		coords.append([float(lon), float(lat)])
	return coords


def makeLineString(placemark: ET.Element) -> list:
	coordinates = placemark.find(".//coordinates", ns).text
	return parseCoordinates(coordinates)


def makePolygon(placemarks: list) -> list:
	result = []
	for p in placemarks:
		linearRing = makeLineString(p)
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
	# Get color and zIndex, if able
	folderName = folder.find("name", ns).text
	if folderName in styles:
		color, zIndex = styles[folderName]
	else:
		# Defaults if folder name not recognized
		print(f"Unrecognized folder name: '{folderName}'. Defaulting to color=#FFFFFF, zIndex=100")
		color = "#ffffff"
		zIndex = 100
	# Parse each placemark
	lineStrings = []
	polygons = []
	placemarkQueue = []
	makeInnerRings = False
	for placemark in folder.iterfind("Placemark", ns):
		if placemark.find("LineString", ns):
			# Add to MultiLineString
			lineStrings.append(makeLineString(placemark))
		elif placemark.find("Polygon", ns):
			# Add to MultiPolygon
			name = placemark.find("name", ns)
			if name is not None:
				# Don't try to extract text if `name` is None
				name = name.text.lower()
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
	# Get additional properties, if present
	description = folder.find("description", ns)
	if description is not None:
		props = json.loads(description.text)
	# Store LineStrings and Polygons, as needed
	if len(lineStrings) > 0:
		feature = {
			"type": "Feature",
			"properties": {
				"color": color,
				"thickness": 1,
				"style": "solid",
				"zIndex": zIndex
			},
			"geometry": {
				"type": "MultiLineString",
				"coordinates": lineStrings
			}
		}
		# Add additional properties, if present
		if description is not None:
			for k,v in props.items():
				feature["properties"][k] = v
		features.append(feature)
	if len(polygons) > 0:
		feature = {
			"type": "Feature",
			"properties": {
				"color": color,
				"zIndex": zIndex
			},
			"geometry": {
				"type": "MultiPolygon",
				"coordinates": polygons
			}
		}
		# Add additional properties, if present
		if description is not None:
			for k,v in props.items():
				feature["properties"][k] = v
		features.append(feature)

# Output
final = {
	"type": "FeatureCollection",
	"features": features
}
with open(filename.rstrip(".kml") + ".geojson", "w") as file:
	json.dump(final, file, indent=2)
	file.write("\n")  # (Finish file with newline)

print("Complete!")
input("Press ENTER to continue . . . ")
