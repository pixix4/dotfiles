#!/bin/sh

volume=$(amixer -D pulse sset Master 2%+ | grep -m 1 "%]" |cut -d "[" -f2|cut -d "%" -f1)

amixer -q -D pulse sset Master unmute

notify-send "volume" -i "/home/lars/dotfiles/screen/volume/ic_volume_up.png" -h int:value:$volume -t 500 -h string:x-canonical-private-synchronous:volume -h string:synchronous:volume -h string:private-synchronous:volume
