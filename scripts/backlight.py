#!/bin/python
import subprocess
import math
import sys

expo = 50
step_count = 30
steps = step_count - 1
red = 0.98

icon = "/home/lars/dotfiles/screen/light/ic_backlight_high.png"

def step_to_backlight(step):
    return (math.pow(expo, step / steps) - red) / (expo - red) * 100

def backlight_to_step(backlight):
    return round(math.log(backlight / 100 * (expo - red) + red, expo) * steps)


current_backlight=float(subprocess.run(['light'], stdout=subprocess.PIPE).stdout.decode('utf-8').strip())
current_step = backlight_to_step(current_backlight)

def print_list():
    for i in range(0,steps + 1):
        selected = " "
        if i == current_step:
            selected = "*"
        print(" {2} {0} -> {1:0.2f}%".format(i,step_to_backlight(i), selected))


def print_backlight():
    print("{0} -> {1:0.2f}%".format(current_step,step_to_backlight(current_step)))

def print_max():
    print(steps)

def print_min():
    print("0")

def set_backlight(value):
    x = int(value)
    if not math.isfinite(x):
        x = current_step
    x = max(0, min(steps, x))

    b = step_to_backlight(x)
    subprocess.run(['light', '-S', str(b)])
    subprocess.run(['notify-send', 'dsp', '-i', icon, '-h', 'int:value:'+str(x / steps * 100), '-t', '500', '-h', 'string:synchronous:dsp'])

def darker():
    set_backlight(current_step - 1)

def lighter():
    set_backlight(current_step + 1)

def lightest():
    set_backlight(steps)

def darkest():
    set_backlight(0)

def print_help():
    pass

if len(sys.argv) <= 1:
    print_backlight()
else:
    p = sys.argv[1]
    if p == "get":
        print_backlight()
    elif p == "list":
        print_list()
    elif p == "min":
        print_min()
    elif p == "max":
        print_max()
    elif p == "set":
        set_backlight(float(sys.argv[2]))
    elif p == "darker":
        darker()
    elif p == "lighter":
        lighter()
    elif p == "lightest":
        lightest()
    elif p == "darkest":
        darkest()
    elif p == "help":
        print_help()
    else:
        print("Unknown command {}".format(p))
