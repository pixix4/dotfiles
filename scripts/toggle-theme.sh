#!/bin/bash

file=/home/lars/.theme

theme=$(cat $file)

text="Error"
icon=""

if [ $theme -eq "1" ]; then
    # light -> dark
    echo "2" > $file

    cp /home/lars/dotfiles/termite/config_dark /home/lars/dotfiles/termite/config
    feh --bg-fill /home/lars/dotfiles/backgrounds/10-Night.png
    j4-make-config solarized_dark

    i3-msg reload
    killall -USR1 termite

    text="Dark Theme"
    icon="/home/lars/dotfiles/screen/light/ic_backlight_low.png"
elif [ $theme -eq "2" ]; then
    # dark -> auto
    echo "0" > $file

    /home/lars/dotfiles/scripts/update-theme.sh

    text="Auto Theme"
    icon="/home/lars/dotfiles/screen/light/ic_backlight_auto.png"
else
    # auto -> light
    echo "1" > $file

    cp /home/lars/dotfiles/termite/config_light /home/lars/dotfiles/termite/config
    feh --bg-fill /home/lars/dotfiles/backgrounds/04-Day.png
    j4-make-config solarized_light

    i3-msg reload
    killall -USR1 termite

    text="Light Theme"
    icon="/home/lars/dotfiles/screen/light/ic_backlight_high.png"
fi

notify-send $text -i $icon -h string:synchronous:dsp
