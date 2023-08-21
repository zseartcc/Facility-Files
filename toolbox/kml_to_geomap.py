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
	"Filters": "",
	"Style": "Solid",
	"Thickness": "1"
	})
elements = ET.SubElement(geomap, "Elements")


def process_line_segment(start_coords, end_coords, elements,zindex):
    element = ET.SubElement(elements, "Element", attrib={
        "xsi:type": "Line",
        "Filters": "",
        "StartLat": start_coords[1],
        "StartLon": start_coords[0],
        "EndLat": end_coords[1],
        "EndLon": end_coords[0],
        "Zindex": zindex,
    })

def process_polygon(coordinates, elements,zindex):
    polygon_element = ET.SubElement(elements, "Element", attrib={
        "xsi:type": "Polygon",
        "Filters": "",
        "Coordinates": " ".join(f"{lon},{lat},0" for lon, lat in coordinates),
        "Zindex": zindex,
    })


for line in kmlFile.iterfind(".//coordinates", ns):
    coords = cleanCoords(line.text)
    parent_folder = None
    zindex = 1

    # Find the parent Folder element
    parent = line
    while parent is not None:
        parent = parent.getprevious()
        if parent is not None and parent.tag.endswith("Folder"):
            parent_folder = parent.find(".//name", ns).text
            break

    if parent_folder == "runway":
        zindex = 2
    elif parent_folder == "whitepaint":
        zindex = 3
    elif parent_folder == "yellowpaint":
        zindex = 4
    elif parent_folder == "structure":
        zindex = 5
    # Skip points or empty line segments
    if len(coords) < 2:
        continue
    # Split LineStrings into individual line segments
    for i in range(len(coords)-1):
        process_line_segment(coords[i], coords[i+1], elements,zindex)

for polygon_coords in kmlFile.iterfind(".//Polygon//coordinates", ns):
    parent_folder = None
    zindex = 1

    # Find the parent Folder element
    parent = polygon_coords
    while parent is not None:
        parent = parent.getprevious()
        if parent is not None and parent.tag.endswith("Folder"):
            parent_folder = parent.find(".//name", ns).text
            break

    if parent_folder == "runway":
        zindex = 2
    elif parent_folder == "whitepaint":
        zindex = 3
    elif parent_folder == "yellowpaint":
        zindex = 4
    elif parent_folder == "structure":
        zindex = 5
    

    polygon_coords_text = polygon_coords.text
    polygon_coords_cleaned = cleanCoords(polygon_coords_text)
    # Skip polygons with too few coordinates
    if len(polygon_coords_cleaned) < 3:
        continue
    process_polygon(polygon_coords_cleaned, elements,zindex)


outputFilename = inputFilename.strip(".kml") + ".xml"
with open(outputFilename, "wb") as outputFile:
	ET.indent(geomap)
	outputFile.write(ET.tostring(geomap))
	outputFile.write(b"\n")

print("Complete!")
input("\nPress ENTER to continue . . . ")
