#!/bin/sh

volume=$(pamixer --get-volume)

mute=$(pamixer --get-mute)

icon="/home/lars/dotfiles/icons/volume/ic_volume_off.png"

message=$volume
if [ "$mute" == "false" ]; then
    pamixer --mute
    message="mute"
else
    icon="/home/lars/dotfiles/icons/volume/ic_volume_up.png"
    pamixer --unmute
fi

notify-send "Volume: $message" -i $icon -t 500 -h int:value:$volume -h string:x-canonical-private-synchronous:volume
