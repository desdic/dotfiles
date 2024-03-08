#!/bin/bash

WALLPAPERPATH=~/Pictures/wallpapers
WALLPAPER=$(find ${WALLPAPERPATH} -type f -iname '*.jpg'|sort -R|tail -1)
cp "${WALLPAPER}" ~/.cache/current_wallpaper.jpg
/sbin/convert ~/.cache/current_wallpaper.jpg ~/.cache/current_wallpaper.png&
/sbin/wal -q -s -t -i ~/.cache/current_wallpaper.jpg
/sbin/swww img ~/.cache/current_wallpaper.jpg
