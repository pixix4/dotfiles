#!/bin/bash

h=$(grep [0-9][0-9] ~/.fehbg -o)
curr=$(($h - 1))
res=$(ls ~/dotfiles/backgrounds | rofi -dmenu -p 'Display' -i -no-custom -selected-row $curr)

echo "help"
echo $res

if [ -z "$res" ] ; then
    exit
fi

feh --bg-fill ~/dotfiles/backgrounds/$res
