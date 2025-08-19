#!/bin/bash

CONFIG_FILES="$HOME/.config/niri/waybar/config.jsonc $HOME/.config/niri/waybar/style.css /$HOME/.cache/wal/colors-waybar.css"

trap "killall waybar" EXIT

while true; do
    waybar -c ~/.config/niri/waybar/config.jsonc -s ~/.config/niri/waybar/style.css&
    inotifywait -e create,modify $CONFIG_FILES
    killall waybar
    sleep 0.2
done
