#!/bin/bash

setsid termite --exec='bash -c "pacaur -Syyu && /usr/tweaks/update.py --reset"' &