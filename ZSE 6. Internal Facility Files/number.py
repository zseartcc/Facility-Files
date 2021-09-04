# Use to number files (e.g. 100_APD.xml, 110_VORs.xml, 120_MVA.xml, ...)

import os
n = 100
extension = input("File extension: .")
for entry in os.listdir():
	if entry.endswith("." + extension):
		os.rename(entry, str(n) + entry[entry.index("_"):])
		n += 10