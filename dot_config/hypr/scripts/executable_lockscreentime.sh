#!/bin/sh

timeswaylock=600
timeoff=660

if [ -f "/usr/bin/swayidle" ]; then
    /usr/bin/swayidle -w timeout $timeswaylock 'swaylock -f' timeout $timeoff 'hyprctl dispatch dpms off' resume 'hyprctl dispatch dpms on' before-sleep 'swaylock -f' after-resume "$HOME/.config/hypr/scripts/changewallpaper.sh"
else
    echo "swayidle not installed."
fi;
