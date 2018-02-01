#!/bin/sh

volume=$(amixer -D pulse sget Master | grep -m 1 "%]" |cut -d "[" -f2|cut -d "%" -f1)

mute=$(amixer -D pulse sget Master | grep "off" | wc -l)

icon="~/dotfiles/screen/volume/ic_volume_off.png"

if [ $mute -eq 0 ]; then
    amixer -q -D pulse sset Master mute
else 
    icon="~/dotfiles/screen/volume/ic_volume_up.png"
    amixer -q -D pulse sset Master unmute
fi

notify-send "volume" -i $icon -h int:value:$volume -t 500 -h string:x-canonical-private-synchronous:volume -h string:synchronous:volume -h string:private-synchronous:volume
