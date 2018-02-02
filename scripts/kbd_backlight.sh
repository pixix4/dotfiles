#!/bin/bash
# Adjust the keyboard backlight level

shopt -s -o nounset

declare -i KBD_BACKLIGHT_MAX=`cat /sys/class/leds/asus\:\:kbd_backlight/max_brightness`
declare -i KBD_BACKLIGHT_LEV=`cat /sys/class/leds/asus\:\:kbd_backlight/brightness` 

# We need a parameter, etiher inc or dec
if [ $# -eq 0 ] ; then
    exit 192
fi 

icon="/home/lars/dotfiles/screen/light/ic_keyboard.png"

case $1 in
    -i|--inc) 
        if [ ${KBD_BACKLIGHT_LEV} -lt ${KBD_BACKLIGHT_MAX}  ] ; then
            KBD_BACKLIGHT_LEV=${KBD_BACKLIGHT_LEV}+1
        fi
    ;;
    -d|--dec)
        if [ ${KBD_BACKLIGHT_LEV} -gt 0 ] ; then
            KBD_BACKLIGHT_LEV=${KBD_BACKLIGHT_LEV}-1
        fi
    ;;
    -s|--set)
        if [ $2 -lt 0 ] ; then
            KBD_BACKLIGHT_LEV=0
        elif [ $2 -gt $KBD_BACKLIGHT_MAX ]; then
            KBD_BACKLIGHT_LEV=$KBD_BACKLIGHT_MAX
        else
            KBD_BACKLIGHT_LEV=$2
        fi
    ;;
esac

sudo echo ${KBD_BACKLIGHT_LEV} | tee /sys/class/leds/asus::kbd_backlight/brightness

VALUE=$(expr $KBD_BACKLIGHT_LEV \* 100)
VALUE=$(expr $VALUE / $KBD_BACKLIGHT_MAX)

notify-send "kbp" -i $icon -h int:value:$VALUE -t 500 -h string:x-canonical-private-synchronous:dsp -h string:synchronous:dsp -h string:private-synchronous:dsp

