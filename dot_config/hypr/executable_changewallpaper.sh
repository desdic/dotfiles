#!/bin/bash

WALLPAPERPATH=~/Pictures/wallpapers

WALLPAPER=$(find ${WALLPAPERPATH}|sort -R|tail -1)

/sbin/swww img "${WALLPAPER}"
