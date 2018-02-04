#!/bin/bash

device=14

if xinput list-props $device | grep "Device Enabled ([0-9]*):.*1" > /dev/null
then
  xinput disable $device
  value="Off"
else
  xinput enable $device
  value="On"
fi
notify-send "Trackpad" "$value" -t 500 -i "/home/lars/dotfiles/screen/light/ic_touch_app.png" -h string:x-canonical-private-synchronous:volume
