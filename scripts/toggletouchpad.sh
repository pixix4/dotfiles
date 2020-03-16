#!/bin/bash

device=$(xinput list | grep "Synaptics" | xargs -n 1 | grep "id=" | sed 's/id=//g')

if xinput list-props $device | grep "Device Enabled ([0-9]*):.*1" > /dev/null
then
  xinput disable $device
  value="Off"
else
  xinput enable $device
  value="On"
fi
notify-send "Touchpad" "$value" -t 500 -i "/home/lars/dotfiles/icons/light/ic_touch_app.png" -h string:x-canonical-private-synchronous:volume
