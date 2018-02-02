#!/bin/bash
# Adjust the keyboard backlight level

shopt -s -o nounset

declare -i DSP_BACKLIGHT_MAX=`cat /sys/class/backlight/intel_backlight/max_brightness`
declare -i DSP_BACKLIGHT_LEV=`cat /sys/class/backlight/intel_backlight/brightness` 

# We need a parameter, etiher inc or dec
if [ $# -eq 0 ] ; then
    exit 192
fi 

icon="/home/lars/dotfiles/screen/light/ic_backlight_high.png"

case $1 in
    -i|--inc) 
        if [ ${DSP_BACKLIGHT_LEV} -lt ${DSP_BACKLIGHT_MAX}  ] ; then
            DSP_BACKLIGHT_LEV=${DSP_BACKLIGHT_LEV}+5
        else
            DSP_BACKLIGHT_LEV=$DSP_BACKLIGHT_MAX
        fi
    ;;
    -d|--dec)
        if [ ${DSP_BACKLIGHT_LEV} -gt 0 ] ; then
            DSP_BACKLIGHT_LEV=${DSP_BACKLIGHT_LEV}-5
        else
            DSP_BACKLIGHT_LEV=0
        fi
    ;;
    -s|--set)
        if [ $2 -lt 0 ] ; then
            DSP_BACKLIGHT_LEV=0
        elif [ $2 -gt $DSP_BACKLIGHT_MAX ]; then
            DSP_BACKLIGHT_LEV=$DSP_BACKLIGHT_MAX
        else
            DSP_BACKLIGHT_LEV=$2
        fi  
    ;;
esac

sudo echo $DSP_BACKLIGHT_LEV | tee /sys/class/backlight/intel_backlight/brightness

VALUE=$(expr $DSP_BACKLIGHT_LEV \* 100)
VALUE=$(expr $VALUE / $DSP_BACKLIGHT_MAX)

notify-send "dsp" -i $icon -h int:value:$VALUE -t 500 -h string:x-canonical-private-synchronous:dsp -h string:synchronous:dsp -h string:private-synchronous:dsp

