# Copy and paste this script into the same folder as the
# .geojson video maps

import os

faaID = input("FAA 3LD: ")

for file in os.listdir():
	if file.endswith(".geojson"):
		os.rename(file, f"{faaID}__"+file)