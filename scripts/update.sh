#!/bin/bash

setsid termite --exec='bash -c "yes \"\" | yay -Syyu; /home/lars/dotfiles/scripts/update.py --reset"' &
