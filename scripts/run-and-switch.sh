#! /bin/bash

let COUNT=`wmctrl -x -l | grep $1 | wc -l`

if [ $COUNT -eq 0 ] ; then
    $2 &
fi

#wmctrl -x -a $1
#i3-msg workspace $3
#bspc desktop -f $3
swaymsg workspace "\"$3\""

