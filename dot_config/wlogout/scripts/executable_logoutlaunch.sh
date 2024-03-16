#!/usr/bin/env sh

wlTmplt="${XDG_CONFIG_HOME:-$HOME/.config}/wlogout/style.css"
# # detect monitor res
x_mon=$(hyprctl -j monitors | jq '.[] | select(.focused==true) | .width')
y_mon=$(hyprctl -j monitors | jq '.[] | select(.focused==true) | .height')
hypr_border=$(hyprctl -j getoption decoration:rounding | jq '.int')
hypr_scale=$(hyprctl -j monitors | jq '.[] | select (.focused == true) | .scale' | sed 's/\.//')

export x_mgn=$(( x_mon * 35 / hypr_scale ))
export y_mgn=$(( y_mon * 25 / hypr_scale ))
export x_hvr=$(( x_mon * 32 / hypr_scale ))
export y_hvr=$(( y_mon * 20 / hypr_scale ))
#
# # scale font size
export fntSize=$(( y_mon * 2 / 100 ))
export active_rad=$(( hypr_border * 5 ))
export button_rad=$(( hypr_border * 8 ))
#
# # eval config files
envsubst < "$wlTmplt" > ~/.cache/wlogout.css

# launch wlogout
wlogout -b 2 -c 0 -r 0 -m 0 --layout ~/.config/wlogout/layout --css ~/.cache/wlogout.css --protocol layer-shell

