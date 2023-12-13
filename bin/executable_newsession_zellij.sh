#!/bin/bash

ZELLIJ=/usr/bin/zellij

[ ! -x "${ZELLIJ}" ] && exit 1

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
    ${ZELLIJ} --session work action new-tab
    ;;
esac
