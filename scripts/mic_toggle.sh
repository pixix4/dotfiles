#!/bin/sh

s=$(pamixer --list-sources | grep "input" | cut -d" " -f1)
volume=$(pamixer --source $s --get-volume)
mute=$(pamixer --source $s --get-mut)

icon="/home/lars/dotfiles/icons/volume/ic_mic_off.png"

message=$volume
if [ "$mute" == "false" ]; then
    pamixer --source $s --mute
    message="mute"
else
    icon="/home/lars/dotfiles/icons/volume/ic_mic.png"
    pamixer --source $s --unmute
fi

notify-send "Micro: $message" -i $icon -t 500 -h int:value:$volume -h string:x-canonical-private-synchronous:volume
