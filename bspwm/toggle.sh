#!/bin/bash

state=$1; 
bspc query -N -n "focused.$state" && state="tiled"; 
bspc node -t "$state"
