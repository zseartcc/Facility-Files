# Copy and paste this script into the same folder as the
# .geojson video maps

import os

faaID = input("FAA 3LD: ")

for filename in os.listdir():
	if filename.endswith(".geojson"):
		os.rename(filename, faaID + "__" + filename)