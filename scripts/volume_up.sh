#!/bin/sh

pamixer -i 2
volume=$(pamixer --get-volume)
pamixer --unmute

notify-send "Volume: $volume" -i "/home/lars/dotfiles/icons/volume/ic_volume_up.png" -t 500 -h int:value:$volume -h string:x-canonical-private-synchronous:volume
