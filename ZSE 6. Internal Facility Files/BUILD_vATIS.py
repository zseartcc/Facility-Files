import gzip
import os
import xml.etree.ElementTree as ET


# Path to EDIT vATIS folder (with trailing "/")
EDIT_PATH = "EDIT vATIS/"

# Path to vATIS pre-release folder (with trailing "/")
PR_PATH = "Pre-Release/ZSE vATIS WIP/"


# For each EDIT file...
for file in os.listdir(EDIT_PATH):
	if file.endswith(".xml"):
		print(file)
		# Get icao ident and name
		tree = ET.parse(EDIT_PATH + file)
		root = tree.getroot()
		icao = root.get("ID")
		name = root.get("Name")
		# Write to pre-release file
		with gzip.open(PR_PATH + f"vATIS Facility - {name} ({icao}).gz", "w") as prfile:
			if hasattr(ET, "indent"):
				# (ET.indent only works in Python 3.9+)
				ET.indent(tree)
			tree.write(prfile)


print("\nDone!\n")
input("Press Enter to continue . . . ")
