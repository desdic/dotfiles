#!/bin/bash

echo "1" > $HOME/.cache/waybar.reload

CONFIG_FILES="$HOME/.config/hypr/waybar/config $HOME/.config/hypr/waybar/style.css $HOME/.cache/wal/colors-waybar.css $HOME/.cache/waybar.reload"

trap "killall waybar" EXIT

while true; do
    waybar -c ~/.config/hypr/waybar/config -s ~/.config/hypr/waybar/style.css&
    inotifywait -e create,modify $CONFIG_FILES
    killall waybar
    sleep 0.2
done
