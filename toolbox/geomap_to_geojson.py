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

for element in geomap.iterfind(".//Element"):
    element_type = element.get("{http://www.w3.org/2001/XMLSchema-instance}type")
    
    if element_type == "Line":
        startLat = float(element.get("StartLat"))
        startLon = float(element.get("StartLon"))
        endLat = float(element.get("EndLat"))
        endLon = float(element.get("EndLon"))
        
        feature = {
            "type": "Feature",
            "geometry": {
                "type": "LineString",
                "coordinates": [(startLon, startLat), (endLon, endLat)]
            },
            "properties": {
                  
			},
        }
        output["features"].append(feature)
    
    elif element_type == "Polygon":
        coordinates_str = element.get("Coordinates")
        coordinates_list = [list(map(float, coord.split(','))) for coord in coordinates_str.split()]
        
        feature = {
            "type": "Feature",
            "geometry": {
                "type": "Polygon",
                "coordinates": [coordinates_list]
            }
        }
        output["features"].append(feature)

outputName = filename.strip(".xml") + ".geojson"
with open(outputName, "w") as outputFile:
	json.dump(output, outputFile, indent=2)

print("Complete!")
input("\nPress ENTER to continue . . . ")
