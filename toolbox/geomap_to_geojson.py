import json
import sys
from tkinter.filedialog import askopenfilename
import xml.etree.ElementTree as ET


filename = askopenfilename(
	title="Select GeoMap",
	initialdir=".",
	filetypes=[("GeoMap","*.xml")],
	multiple=False
	)
if not filename:
	sys.exit()
geomap = ET.parse(filename)

output = {
	"type": "FeatureCollection",
	"features": []
}

for line in geomap.iterfind(".//Element"):
	startLat = float(line.get("StartLat"))
	startLon = float(line.get("StartLon"))
	endLat = float(line.get("EndLat"))
	endLon = float(line.get("EndLon"))
	feature = {
		"type": "Feature",
		"geometry": {
			"type": "LineString",
			"coordinates": [(startLon,startLat), (endLon,endLat)]
		}
	}
	output["features"].append(feature)

outputName = filename.strip(".xml") + ".geojson"
with open(outputName, "w") as outputFile:
	json.dump(output, outputFile, indent=2)

print("Complete!")
input("\nPress ENTER to continue . . . ")
