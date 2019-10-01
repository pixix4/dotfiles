#!/bin/sh

volume=$(amixer -D pulse sget Capture | grep -m 1 "%]" |cut -d "[" -f2|cut -d "%" -f1)

mute=$(amixer -D pulse sget Capture | grep "off" | wc -l)

icon="/home/lars/dotfiles/screen/volume/ic_mic_off.png"

if [ $mute -eq 0 ]; then
    amixer -q -D pulse sset Capture toggle
else
    icon="/home/lars/dotfiles/screen/volume/ic_mic.png"
    amixer -q -D pulse sset Capture toggle
fi

notify-send "mic" -i $icon -t 500 -h int:value:$volume -h string:x-canonical-private-synchronous:volume
