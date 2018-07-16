#!/bin/bash

file=/home/lars/.theme

theme=$(cat $file)

if [ $theme -eq "1" ]; then
    # ignore
    echo "1"
elif [ $theme -eq "2" ]; then
    # ignore
    echo "2"
else
    /home/lars/dotfiles/scripts/timebased-theming.py | {
            read a;
            read b;

            feh --bg-fill $a

            if [ $b == "light" ]; then
                cp /home/lars/dotfiles/termite/config_light /home/lars/dotfiles/termite/config
                j4-make-config solarized_light
            else
                cp /home/lars/dotfiles/termite/config_dark /home/lars/dotfiles/termite/config
                j4-make-config solarized_dark
            fi;

            i3-msg reload;
            killall -USR1 termite;
        }
fi
