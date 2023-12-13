#!/bin/bash

ZELLIJ=/usr/bin/zellij

 [ ! -x "${ZELLIJ}" ] && exit 1

CHOICE=$(fd . --type directory ~/ ~/.config ~/git ~/git/cookbooks --maxdepth 1|fzf +m --prompt="directory > ")
if [ "$?" -ne 0 ]; then
  exit 0
fi

if ${ZELLIJ} list-sessions --short|grep -q ^work$; then
  LAYOUT=default
  if [ -f "${CHOICE}/Makefile" ]; then
    LAYOUT=development
  elif [ -f "${CHOICE}/.kitchen.yml" ]; then
    LAYOUT=kitchen
  fi

  ${ZELLIJ} --session work action new-tab --cwd "$CHOICE" --layout ${LAYOUT}
fi
