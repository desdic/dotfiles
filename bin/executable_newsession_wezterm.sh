#!/bin/bash

WZ=/sbin/wezterm
HC=/sbin/hyprctl

[ ! -x "${WZ}" ] && exit 1
[ ! -x "${HC}" ] && exit 1

function focus() {
  WS=$(${HC} clients -j|jq -r '.[]| select(.class=="org.wezfurlong.wezterm")|.workspace.id')
  if [ -n "${WS}" ]; then
    ${HC} dispatch workspace "${WS}"

    TRIES=0
    ACTIVE=$(${HC} activewindow -j|jq -r '.initialClass')
    while [[ "${ACTIVE}" != "org.wezfurlong.wezterm" ]]
    do
      TRIES=$((TRIES + 1))
      if [ $TRIES -gt 10 ]; then
        break
      fi
      ${HC} dispatch cyclenext
      ACTIVE=$(${HC} activewindow -j|jq -r '.initialClass')
    done
  fi
}

if /sbin/pgrep -a wezterm-gui; then
  focus
  ID=$(${WZ} cli --prefer-mux spawn)
  ${WZ} cli --prefer-mux activate-tab --tab-id "${ID}"
else
  ${WZ} connect work
  focus
fi
