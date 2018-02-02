#!/bin/bash

execList=()

while [[ $# -gt 0 ]]; do
    case $1 in
        -i|--internal)
            internal="$2"
            shift
            shift
        ;;
        -e|--external)
            external="$2"
            shift
            shift
        ;;
        -h|--help)
cat <<EOF
A rofi script to control an external monitor. 

This script tries to find an internal and external monitor:
If no internal monitor can be found this script fails. 
If no or more than one external monitor(s) are detected this script will only offer an option to disable all monitor ports.

You can also specify what commands should be executed after an screen change.

Usage: 
    ./rofi-xrandr.sh [-i MONITOR] [-e MONITOR] [Commands ...]
    ./rofi-xrandr.sh "i3-msg restart"   //Autodetect internal and external monitor. Execute "i3-msg restart" after screen change
    ./rofi-xrandr.sh -i eDP1 -e HDMI1   //Use 'eDP1' as internal and 'HDMI1' as external monitor

Arguments:
    --internal  -i  Explicitly specify the internal monitor
    --external  -e  Explicitly specify the external monitor
    --help      -h  Prints this help message
EOF
            exit
        ;;
        *)
            execList+=("$1")
            shift
        ;;
    esac
done

if [ -z $internal ]; then
    internal=$(xrandr | grep "primary" | cut -d" " -f1)

    if [ -z $internal ]; then
        echo "Cannot find internal monitor"
        exit 1
    fi
fi

if [ -z $external ]; then
    displays=$(xrandr --query | grep " connected" | cut -d" " -f1 | grep -v $internal)
    count=$(echo $displays | sed '/^\s*$/d' | wc -l)
    if [ $count -eq 1 ]; then
        external=$displays
    fi
fi

internal_only() {
cat <<EOF
┌───────┐ ╭┄┄┄┄╮
│       │ ┆    ┆   Internal screen only
│       │ ╰┄┄┄┄╯
└───────┘
EOF
}
duplicate() {
cat <<EOF
┏━━━━┱──┐
┃    ┃  │           Duplicate ($external)
┡━━━━┛  │
└───────┘
EOF
}
extend() {
cat <<EOF
┌───────┐ ┏━━━━┓
│       │ ┃    ┃    Extend ($external)
│       │ ┗━━━━┛
└───────┘
EOF
}
external_only() {
cat <<EOF
╭┄┄┄┄┄┄┄╮ ┏━━━━┓
┆       ┆ ┃    ┃   External monitor only ($external)
┆       ┆ ┗━━━━┛
╰┄┄┄┄┄┄┄╯
EOF
}


print_full_menu() {
    internal_only
    echo -e '\0'
    duplicate
    echo -e '\0'
    extend
    echo -e '\0'
    external_only
}

print_small_menu() {
    internal_only
}

element_height=5
element_count=4

if [ -z $external ]
then
    menu=print_small_menu
else
    menu=print_full_menu
fi

res=$($menu | rofi -dmenu -sep '\0' -lines "$element_count" -eh "$element_height" -p 'Display' -i -no-custom -format i)

if [ -z "$res" ] ; then
    exit
fi
case "$res" in
    0)
        displays=$(xrandr --query | grep "connected" | cut -d" " -f1 | grep -v $internal)
        for disp in $displays; do
            xrandr --output $disp --off --output $internal --auto --primary
        done
        ;;
    1)
        xrandr --output $internal --auto --primary --output $external --auto --pos 0x0
        ;;
    2)
        xrandr --output $internal --auto --primary --output $external --auto --right-of $internal
        ;;
    3)
        xrandr --output $external --auto --output $internal --off
        ;;
    *)
        ;;
esac

for ((i = 0; i < ${#execList[@]}; i++))
do
    eval "${execList[$i]}"
done
