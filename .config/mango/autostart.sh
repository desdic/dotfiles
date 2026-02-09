#!/bin/bash

/usr/lib/xdg-desktop-portal-wlr&

systemctl --user start noctalia

swayidle -w -C ~/.config/swayidle/config.mango&
wl-clip-persist --clipboard regular --reconnect-tries 0&
wl-paste --type text --watch cliphist store&
dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=wlroots
/usr/lib/xfce-polkit/xfce-polkit &

/sbin/google-chrome-stable&
/sbin/spotify --enable-features=UseOzonePlatform --ozone-platform=wayland&
dino&
/sbin/kitty --app-id=tmux tmux&
