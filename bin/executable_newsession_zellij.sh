#!/bin/bash

ZELLIJ=/usr/bin/zellij
HC=/usr/bin/hyprctl

[ ! -x "${ZELLIJ}" ] && exit 1

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

LAYOUT=""
while getopts w flag
do
  case "${flag}" in
    w) LAYOUT="-l work"
  esac
done

pgrep -a foot|grep -q zellij

case $? in 
  1)
    # I really don't want the last panes to persisist
    if ${ZELLIJ} list-sessions|grep work|grep EXITED; then
      ${ZELLIJ} delete-session work
    fi
    # sleep hack to make zellij get correct size of window
    # https://github.com/zellij-org/zellij/issues/2799
    /sbin/foot -a work zsh --login -c 'sleep 0.1;zellij attach --create work'
    ;;
  *)
    focus
    ${ZELLIJ} --session work action new-tab ${LAYOUT}
    ${ZELLIJ} --session work action rename-tab "~"
    ;;
esac
