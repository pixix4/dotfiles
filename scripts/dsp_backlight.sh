#!/bin/bash
# Adjust the keyboard backlight level

shopt -s -o nounset

declare -i KBD_BACKLIGHT_MAX=`cat /sys/class/backlight/intel_backlight/max_brightness`
declare -i KBD_BACKLIGHT_LEV=`cat /sys/class/backlight/intel_backlight/brightness` 

# We need a parameter, etiher inc or dec
if [ $# -eq 0 ] ; then
   exit 192
fi 

icon="/home/lars/dotfiles/screen/light/ic_backlight_high.png"

case $1 in
-inc ) 
   # increasing:
   if [ ${KBD_BACKLIGHT_LEV} -lt ${KBD_BACKLIGHT_MAX}  ] ; then
      KBD_BACKLIGHT_LEV=${KBD_BACKLIGHT_LEV}+5
   else
      KBD_BACKLIGHT_LEV=$KBD_BACKLIGHT_MAX
   fi
   ;;
-dec )
   # decreasing:
   if [ ${KBD_BACKLIGHT_LEV} -gt 0 ] ; then
      KBD_BACKLIGHT_LEV=${KBD_BACKLIGHT_LEV}-5
   else
      KBD_BACKLIGHT_LEV=0
   fi
   ;;
esac

sudo ~/dotfiles/scripts/dsp_backlight_adjust.sh -set $KBD_BACKLIGHT_LEV

VALUE=$(expr $KBD_BACKLIGHT_LEV \* 100)
VALUE=$(expr $VALUE / $KBD_BACKLIGHT_MAX)

echo $VALUE

notify-send "dsp" -i $icon -h int:value:$VALUE -t 500 -h string:x-canonical-private-synchronous:dsp -h string:synchronous:dsp -h string:private-synchronous:dsp

