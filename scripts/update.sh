#!/bin/bash

setsid termite --exec='bash -c "pacaur -Syyu && /home/lars/dotfiles/scripts/update.py --reset"' &