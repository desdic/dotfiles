#!/bin/bash

DIR=$(fd . --type directory ~/ ~/.config ~/git ~/git/cookbooks ~/src/private --maxdepth 1|fuzzel --dmenu --prompt="Directory: " --width=100 2>/dev/null)
if [ -z "$DIR" ]; then
  exit 0 
fi

if pgrep zellij; then
  LAYOUT=default
  if [ -f "${DIR}/Makefile" ]; then
    LAYOUT=development
  elif [ -f "${DIR}/.kitchen.yml" ]; then
    LAYOUT=kitchen
  fi

  zellij --session work action new-tab --cwd "$DIR" --layout ${LAYOUT}
else
  /sbin/foot --working-directory "$DIR"
fi
