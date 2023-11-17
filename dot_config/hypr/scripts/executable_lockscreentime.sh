#!/bin/sh

timeswaylock=600
timeoff=660

if [ -f "/usr/bin/swayidle" ]; then
    swayidle -w timeout $timeswaylock 'swaylock -f' timeout $timeoff 'hyprctl dispatch dpms off' resume 'hyprctl dispatch dpms on'
else
    echo "swayidle not installed."
fi;
