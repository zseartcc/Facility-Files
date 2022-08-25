import json
import os


# Path to folder containing the composites
COMP_PATH = "EDIT vATIS/COMPOSITES/"

# Path to folder containing the profiles
PROF_PATH = "EDIT vATIS/PROFILES/"

# Path to pre-release vATIS folder
PR_PATH = "Pre-Release/ZSE vATIS WIP/v4/"


print("Assembling profiles:\n")
for entry in os.listdir(PROF_PATH):
	if entry.endswith(".json"):
		# Print the profile's name
		name = entry.strip(".json")
		print(name)
		# Retrieve the profile definition
		with open(PROF_PATH + entry) as f:
			definition = json.load(f)
		# Add the composites
		composites = []
		for airport in definition["Composites"]:
			with open(COMP_PATH + airport + ".json") as f:
				comp = json.load(f)
			composites.append(comp)
		# Save pre-release file
		with open(PR_PATH + f"vATIS Profile - {name}.json", "w") as f:
			json.dump({"Name": name, "Composites": composites}, f, indent="  ")

input("\nComplete!\nPress ENTER to continue . . . ")
