#!/usr/bin/env bash

set -euo pipefail

state=$(playerctl metadata --format ' {{ emoji(status) }} {{markup_escape(title)}} - {{markup_escape(artist)}}'| sed -e 's/▶️//g' -e 's/⏸️//g' )
player_status=$(playerctl -a status)

if [[ "$player_status" =~ "Playing" ]]; then
    printf "%s" "$state"  2>/dev/null
elif [[ "$player_status" =~ "Paused" ]]; then
    printf "%s" "$state"  2>/dev/null
else
    printf "$player_status"
fi
