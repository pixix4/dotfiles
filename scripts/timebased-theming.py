#!/bin/python

import datetime
import os
from sunset_sunrise import SunriseSunset

now = datetime.datetime.now()
time = SunriseSunset(now, latitude=51, longitude=-13.65)
rise_time, set_time = time.calculate()

daystart = now.replace(hour=0, minute=0, second=0, microsecond=0)

current = 0
delta = 1
images = []
theme = None

if now < rise_time:
    current = (now - daystart).seconds
    delta = (rise_time - daystart).seconds
    images = ["11-Night", "12-Night", "01-Morning"]
    theme = "dark"
elif now < set_time:
    current = (now - rise_time).seconds
    delta = (set_time - rise_time).seconds
    images = ["02-Morning", "03-Morning", "04-Day", "04-Day", "05-Day", "05-Day", "06-Day", "06-Day", "07-Evening", "08-Evening"]
    theme = "light"
else:
    current = (now - set_time).seconds
    delta = 60*60*24 - (set_time - daystart).seconds
    images = ["09-Evening", "10-Night", "11-Night"]
    theme = "dark"

x = current / delta
image = images[min(int(x*len(images)), len(images) - 1)]
print("/home/lars/dotfiles/backgrounds/"+image+".png")
print(theme)

