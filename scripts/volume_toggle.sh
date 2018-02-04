#!/bin/sh

volume=$(amixer -D pulse sget Master | grep -m 1 "%]" |cut -d "[" -f2|cut -d "%" -f1)

mute=$(amixer -D pulse sget Master | grep "off" | wc -l)

icon="/home/lars/dotfiles/screen/volume/ic_volume_off.png"

if [ $mute -eq 0 ]; then
    amixer -q -D pulse sset Master mute
else 
    icon="/home/lars/dotfiles/screen/volume/ic_volume_up.png"
    amixer -q -D pulse sset Master unmute
fi

notify-send "volume" -i $icon -t 500 -h int:value:$volume -h string:x-canonical-private-synchronous:volume
