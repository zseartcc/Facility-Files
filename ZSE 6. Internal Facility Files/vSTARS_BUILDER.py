import datetime
import gzip
import os
import time
import tkinter as tk
from tkinter.messagebox import showinfo, showerror
from tkinter.ttk import Progressbar
import xml.etree.ElementTree as ET

import fetools.alias
import fetools.pof


################
#  Parameters  #
################

# Path to 'EDIT vSTARS' folder (no "/" at the end)
S_EDIT_PATH = "EDIT vSTARS"

# Path to vSTARS output folder (no "/" at the end)
S_OUT_PATH = "Pre-Release/ZSE Facility Files WIP/vSTARS"

# Path to VRC Alias file
ALIAS_PATH = "Pre-Release/ZSE Facility Files WIP/ALIAS FILES/ZSE ALIAS.txt"

# Path to VRC POF file
POF_PATH = "Pre-Release/ZSE Facility Files WIP/POF FILE/ZSE POF.pof"


#############
#   Tasks   #
#############

def updateAliases(profId, name, profGZ, config):
	# Load/convert alias file
	with open(ALIAS_PATH) as f:
		aliases = fetools.alias.load(f)._dumpxml()
	# Replace profile's CommandAlias-es with the `aliases` ones
	with gzip.open(profGZ) as facility:
		# Load/parse pre-release .gz file
		tree = ET.parse(facility)
	# Get current CommandAliases element
	current = tree.find(".//CommandAliases")
	# Replace with the new commands
	current[:] = aliases
	# Update CommandAliasesLastImported
	time = datetime.datetime.now().astimezone().isoformat()
	tree.find(".//CommandAliasesLastImported").text = time
	# Write new facility
	with gzip.open(profGZ, "w") as facility:
		if hasattr(ET, "indent"):
			# (ET.indent only works in Python 3.9+)
			ET.indent(tree)
		tree.write(facility)

def updatePositions(profId, name, profGZ, config):
	# Load/convert pof file
	with open(POF_PATH) as f:
		positions = fetools.pof.load(f)._dumpxml()
	# Replace profile's PositionInfo-s with the `positions` ones
	with gzip.open(profGZ) as facility:
		# Load/parse pre-release .gz file
		tree = ET.parse(facility)
	# Get current Positions element
	current = tree.find(".//Positions")
	# Replace with new positions
	current[:] = positions
	# Update PositionsLastImported
	time = datetime.datetime.now().astimezone().isoformat()
	tree.find(".//PositionsLastImported").text = time
	# Write new facility
	with gzip.open(profGZ, "w") as facility:
		if hasattr(ET, "indent"):
			# (ET.indent only works in Python 3.9+)
			ET.indent(tree)
		tree.write(facility)

def updateMaps(profId, name, profGZ, config):
	# Load current pre-release .gz file
	with gzip.open(profGZ) as preRlsFile:
		preRlsXML = ET.parse(preRlsFile)  # (ElementTree object)
	# Replace with new video maps
	videoMaps = preRlsXML.find(".//VideoMaps")
	videoMaps.clear()
	# (Get each video map...)
	for entry in os.scandir(f"{S_EDIT_PATH}/{profId}/VIDEO MAPS"):
		if entry.is_file():
			# (Load it...)
			diagramPath = f"{S_EDIT_PATH}/{profId}/VIDEO MAPS/{entry.name}"
			diagram = ET.parse(diagramPath).getroot()
			videoMaps.append(diagram)
	# Write new video maps to pre-release file
	with gzip.open(profGZ, "w") as preRlsFile:
		if hasattr(ET, "indent"):
			# # (ET.indent only works in Python 3.9+)
			ET.indent(preRlsXML)
		preRlsXML.write(preRlsFile)


def assemble(profId, name, profGZ, config):
	# Load current pre-release .gz file
	with gzip.open(profGZ) as preRlsFile:
		preRlsXML = ET.parse(preRlsFile)  # (ElementTree obj)
	# Update each item
	for new in config.iterfind("./Facility/*"):
		# Ignore ID and Name tags. Must be changed thru vSTARS
		if new.tag in ["ID", "Name"]:
			continue
		old = preRlsXML.find(f".//{new.tag}")
		old.clear()
		# Update children
		for child in new:
			old.append(child)
		# Update attribs and text
		old.attrib = new.attrib
		old.text = new.text
	# Write updated profile
	with gzip.open(profGZ, "w") as preRlsFile:
		if hasattr(ET, "indent"):
			# (ET.indent only works in Python 3.9+)
			ET.indent(preRlsXML)
		preRlsXML.write(preRlsFile)


#####################
#  Main GUI Window  #
#####################

root = tk.Tk()

class App(tk.Frame):
	def __init__(self, parent):
		super().__init__(parent)

		# "Selection" frame
		slctFrame = tk.Frame(self)
		slctFrame.pack()

		# "Select profiles" label
		profileLbl = tk.Label(slctFrame, text="Select one or more profiles:")
		profileLbl.config(padx=20, pady=20)
		profileLbl.grid(row=0, column=0)
		# "Select profiles" Listbox
		profiles = tk.Listbox(slctFrame, selectmode="extended")
		# Assemble list of profiles
		foundProfiles = []
		for item in os.scandir(S_EDIT_PATH):
			if item.is_dir():
				foundProfiles.append(item.name)
		# Add profiles to Listbox
		n = 1
		for profile in sorted(foundProfiles):
			profiles.insert(n, profile)
			n += 1
		profiles.grid(row=1, column=0)

		# "Select tasks" label
		tasksLbl = tk.Label(slctFrame, text="Select one or more tasks to perform:")
		tasksLbl.config(padx=20)
		tasksLbl.grid(row=0, column=1)
		# "Select tasks" frame
		tasksFrame = tk.Frame(slctFrame)
		tasksFrame.grid(row=1, column=1, sticky="n")

		########################################################
		# List of tasks: "(Checkbox label, command/action)"
		tasks = [
			("Update aliases", updateAliases),
			("Update positions", updatePositions),
			("Update video maps", updateMaps),
			("Update profile", assemble)
		]
		########################################################

		taskVars = []  # Stores IntVars for each Checkbutton
		for t in tasks:
			# Create/store var to track each Checkbutton
			iv = tk.IntVar()
			taskVars.append(iv)
			# Create checkbox
			checkbox = tk.Checkbutton(tasksFrame, text=t[0], variable=iv)
			checkbox.pack(side="top", anchor="w")

		# # Debug button (dev testing)
		# b = tk.Button(self, text="Debug")
		# b["command"] = lambda: self.debug(taskVars, profiles)
		# b.pack()

		# Progress bar
		progress = Progressbar(self, length=360)
		progress.pack(pady=(23,0))

		# Status label
		statText = tk.StringVar()
		status = tk.Label(self, textvariable=statText)
		status.pack()

		# "Do Selected" button
		doSelectedBtn = tk.Button(
			tasksFrame, text="Do Selected Tasks", activebackground="#00ff00",
			command=lambda: self.doTasks(profiles, tasks, taskVars, progress, statText),
			bg="#88ff88", pady=5, padx=5
		)
		doSelectedBtn.pack(pady=10)

		self.config(padx=20)
		self.pack()

	def doTasks(self, listbox, tasks, chkBoxVars, progBar, statText):
		# Get the selected profiles
		profiles = []
		for ind in listbox.curselection():
			profiles.append(listbox.get(ind))
		# Get the selected tasks
		todo = []
		for i in range(len(chkBoxVars)):
			# If the checkbox is ticked
			if chkBoxVars[i].get():
				# Add corresponding task func to todo list
				todo.append(tasks[i][1])
		# For each profile, run all tasks (and progress bar)
		progBar["value"] = 1  # Start at 1 just to show something's happening
		for profile in profiles:
			# Get profile's name
			config = ET.parse(f"{S_EDIT_PATH}/{profile}/profile.xml").getroot()
			name = config.find("./Facility/Name").text
			# Get profile's current pre-release .gz file
			preRlsFile = f"{S_OUT_PATH}/vSTARS Facility - {name} ({profile}).gz"
			for task in todo:
				statText.set(f"             {profile}: {task.__name__}             ")
				root.update_idletasks()  # (Updates GUI after each task is run)
				try:
					# Run task!
					task(profId=profile, name=name, profGZ=preRlsFile, config=config)
				except Exception as e:
					title = type(e).__name__
					message = f"({task.__name__}, {profile})\n{e}"
					showerror(title=title, message=message)
					print(f"{profile}: {task.__name__}")
					raise e
				# After 1st task completes, pretend like we started at 0, not 1
				if progBar["value"] == 1:
					progBar["value"] = 0
				# Update progress bar
				progBar["value"] += 100 / (len(profiles) * len(todo))
		showinfo(message="Done!")
		progBar["value"] = 0

	def debug(self, taskVars, profiles):
		# Print task checkbox values
		print([tv.get() for tv in taskVars])
		# Print selected profiles
		print(profiles.curselection())
		print()


##########
#  Main  #
##########

if __name__ == "__main__":
	root.title("vSTARS Profile Builder")
	root.geometry("500x300")
	root.resizable(False, False)
	app = App(root)
	root.mainloop()
