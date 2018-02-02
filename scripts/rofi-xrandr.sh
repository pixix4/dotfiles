#!/bin/bash

internal=$(xrandr | grep "primary" | cut -d" " -f1)
external=

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
internal_only() {
cat <<EOF
┌───────┐ ╭┄┄┄┄╮
│       │ ┆    ┆   Internal screen only
│       │ ╰┄┄┄┄╯
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

print_menu() {
    if [ $line_count -eq 1 ]
    then
        external=$displays
        print_full_menu
    else
        print_small_menu
    fi
}

update_wm() {
    i3-msg restart
}

disable_screensaver() {
    xset -dpms
    xset s off
}

enable_screensaver() {
    xset +dpms
}

displays=$(xrandr --query | grep " connected" | cut -d" " -f1 | grep -v $internal)
line_count=$(xrandr --query | grep " connected" | cut -d" " -f1 | grep -v $internal | wc -l)

element_height=5
element_count=4

if [ $# -ge 1 ]
then
	internal=$1
fi

if [ $line_count -eq 1 ]
then
    external=$displays
fi

res=$(print_menu | rofi -dmenu -sep '\0' -lines "$element_count" -eh "$element_height" -p '' -no-custom -format i)

if [ -z "$res" ] ; then
    exit
fi
case "$res" in
    0)
        displays=$(xrandr --query | grep "connected" | cut -d" " -f1 | grep -v $internal)
        for disp in $displays; do
            xrandr --output $disp --off --output $internal --auto --primary
        done
        #enable_screensaver
        ;;
    1)
        xrandr --output $internal --auto --primary --output $external --auto --pos 0x0
        #disable_screensaver
        ;;
    2)
        xrandr --output $internal --auto --primary --output $external --auto --right-of $internal
        #disable_screensaver
        ;;
    3)
        xrandr --output $external --auto --output $internal --off
        #enable_screensaver
        ;;
    *)
        ;;
esac

update_wm
