#!/bin/bash

theme=$(cat ~/.theme)

if [ $theme -eq "2" ]; then
    cp ~/dotfiles/termite/config_light ~/dotfiles/termite/config
    feh --bg-fill ~/dotfiles/backgrounds/04-Day.png
    echo "1" > ~/.theme
    fish -c "set -Ux theme_color_scheme solarized-light"
else
    cp ~/dotfiles/termite/config_dark ~/dotfiles/termite/config
    feh --bg-fill ~/dotfiles/backgrounds/10-Night.png
    echo "2" > ~/.theme
    fish -c "set -Ux theme_color_scheme solarized-dark"
fi
killall -USR1 termite
