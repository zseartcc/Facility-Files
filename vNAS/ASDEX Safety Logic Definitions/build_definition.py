import json
import sys
import xml.etree.ElementTree as ET

# Namespace definitions
ns = {"": "http://www.opengis.net/kml/2.2"}


def cleanCoords(coordText: str) -> list:
	output = []
	for point in coordText.strip().split():
		lon, lat, _ = point.split(",")
		output.append((float(lon), float(lat)))
	return output


# Get kml file
filename = sys.argv[1]
tree = ET.parse(filename)
top = tree.find("Document/Folder", ns)


features = []

# Process each feature type
for folder in top.iterfind("Folder", ns):
	folderName = folder[0].text
	# Check folder naming
	if folderName not in ["Runways", "Taxiways", "Hold Short Bars"]:
		raise Exception(f"Folder name must be 'Runways', 'Taxiways', or 'Hold Short Bars', not '{folderName}'")
	# Process each placemark in folder
	for placemark in folder.iterfind("Placemark", ns):
		# Get coordinates
		coordText = placemark.find(".//coordinates", ns).text
		coords = cleanCoords(coordText)
		# Assemble feature
		feature = {
			"type": "Feature",
			"geometry": {
				"type": "LineString" if folderName == "Hold Short Bars" else "Polygon",
				"coordinates": coords if folderName == "Hold Short Bars" else [coords]
			},
			"properties": {}
		}
		# Add properties
		if folderName == "Hold Short Bars":
			feature["properties"] = {
				"runwayId": placemark.find("name", ns).text,
				"crossRunwayId": None,
				"taxiwayId": None
			}

		else:
			feature["properties"]["id"] = placemark.find("name", ns).text
		features.append(feature)

# Assemble GeoJSON
final = {
	"type": "FeatureCollection",
	"features": features
}

with open(filename.strip(".kml")+".geojson", "w") as outFile:
	json.dump(final, outFile, indent="  ")

print("Complete!\n\nCheck output for keys set to null\nProofread all hold short bar properties")
input("\nPress ENTER . . . ")