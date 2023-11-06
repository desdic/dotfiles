#!/bin/bash

ZELLIJ=/usr/bin/zellij

[ ! -x "${ZELLIJ}" ] && exit 1

pgrep -a foot|grep -q zellij

case $? in 
  1)
    # sleep 1 hack to make zellij get correct size of window
    /sbin/foot -a work zsh --login -c 'sleep 1;zellij --config ~/.config/zellij/config.kdl attach --create work'
    ;;
  *)
    ${ZELLIJ} --session work action new-tab
    ;;
esac
