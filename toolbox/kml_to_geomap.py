import sys
from tkinter.filedialog import askopenfilename
import xml.etree.ElementTree as ET


ns = {"": "http://www.opengis.net/kml/2.2"}


def cleanCoords(text) -> [(str,str)]:
	coords = []
	for point in text.strip().split():
		lon, lat, _ = point.split(",")
		lon = str(round(float(lon), 7))
		lat = str(round(float(lat), 7))
		coords.append((lon, lat))
	return coords


inputFilename = askopenfilename(
	title="Select Google Earth file",
	initialdir=".",
	filetypes=[("KML File","*.kml")]
	)
if not inputFilename:
	sys.exit()
with open(inputFilename) as file:
	kmlFile = ET.parse(file)

geomap = ET.Element("GeoMapObject", attrib={
	"Description": "Unnamed GeoMapObject",
	"TdmOnly": "false",
	"xmlns:xsi": "http://www.w3.org/2001/XMLSchema-instance"
	})
ET.SubElement(geomap, "LineDefaults", attrib={
	"Bcg": "",
	"Style": "Solid",
	"Thickness": "1"
	})
elements = ET.SubElement(geomap, "Elements")


for line in kmlFile.iterfind(".//coordinates", ns):
	coords = cleanCoords(line.text)
	# Skip points or empty line segments
	if len(coords) < 2:
		continue
	element = ET.SubElement(elements, "Element", attrib={
		"xsi:type": "Line",
		"Filters": "",
		"StartLat": coords[0][1],
		"StartLon": coords[0][0],
		"EndLat": coords[1][1],
		"EndLon": coords[1][0]
		})


outputFilename = inputFilename.strip(".kml") + ".xml"
with open(outputFilename, "wb") as outputFile:
	ET.indent(geomap)
	outputFile.write(ET.tostring(geomap))
	outputFile.write(b"\n")

print("Complete!")
input("\nPress ENTER to continue . . . ")
