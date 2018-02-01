#!/bin/python

import sys, time, _thread as thread, subprocess, os.path

SLEEP_TIME = 60 # wait 60 seconds between refresh

LAST_OUTPUT_FILE = ".lastOutput"
LAST_REFRESH_FILE = ".lastRefresh"

DELIMITER = "  "

def get_time():
	return int(round(time.time()))

def readLineOfFile(file):
	first_line = ""
	if os.path.isfile(file): 
		with open(file, "r") as f:
			first_line = f.read()
			f.close()
	return first_line

def writeLineToFile(line, file):
	with open(file, "w") as f:
		f.write(str(line))
		f.close

def executeCommandAndCountLines(command):
	proc = subprocess.Popen(command, stdout=subprocess.PIPE)
	return len(proc.stdout.readlines())

def executeCommand(command):
	proc = subprocess.Popen(command)


def update():
	writeLineToFile(get_time()+SLEEP_TIME, LAST_REFRESH_FILE)
	writeLineToFile("Updating...", LAST_OUTPUT_FILE)
	executeCommand(["/usr/tweaks/update.sh"])

def check_updates():
	writeLineToFile(get_time()+SLEEP_TIME, LAST_REFRESH_FILE)

	pac = executeCommandAndCountLines(["checkupdates"])
	aur = executeCommandAndCountLines(["cower", "-uq"])
	writeLineToFile(str(pac) + DELIMITER + str(aur), LAST_OUTPUT_FILE)

def show():
	line = readLineOfFile(LAST_OUTPUT_FILE)
	if line == "":
		line = "-"+DELIMITER+"-"
		check_updates()
	else:
		last_time = readLineOfFile(LAST_REFRESH_FILE)
		if (last_time == ""):
			last_time = 0
		else: 
			last_time = int(last_time)

		if (last_time < get_time()):
			check_updates()

	print(line)

def reset():
	check_updates()

def unknown():
	print("Option is not recognized!")

def main():
	if len(sys.argv) == 1:
		update()
	else:
		param = sys.argv[1]
		if param == "--show":
			show()
		elif param == "--reset":
			reset()
		else:
			unknown()

if __name__ == "__main__":
    main()
