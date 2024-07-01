#!/bin/bash

KITTY=/sbin/kitty
KITTEN=/sbin/kitten
HC=/usr/bin/hyprctl
SOCKET=/tmp/kittywork

[ ! -x "${KITTY}" ] && exit 1

function focus() {
  WS=$(${HC} clients -j|jq -r '.[]| select(.class=="work")|.workspace.id')
  if [ -n "${WS}" ]; then
    ${HC} dispatch workspace "${WS}"

    TRIES=0
    ACTIVE=$(${HC} activewindow -j|jq -r '.initialClass')
    while [[ "${ACTIVE}" != "work" ]]
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

focus

if pgrep -f '/sbin/kitty --app-id=work'; then
  ${KITTEN} @ --to unix:${SOCKET} action new_tab
else
  ${KITTY} --app-id=work -o allow_remote_control=yes --listen-on unix:${SOCKET}
fi
