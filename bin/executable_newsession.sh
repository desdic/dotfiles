#!/bin/sh

TMUX=/usr/bin/tmux

[ ! -x ${TMUX} ] && exit 1

LANG=da_US.UTF-8

RES=$(${TMUX} ls -F "#{session_name}_#{?session_attached,attached,not_attached}"|grep ^work_)

case ${RES} in
  work_attached)
    ${TMUX} new-window -t work
    ;;
  work_not_attached)
    if [[ "${XDG_SESSION_TYPE}" == "wayland" ]]; then
      /sbin/foot -a work ${TMUX} attach -t work
    else
      /sbin/alacritty --class work -e ${TMUX} attach -t work
    fi
    ;;
  *)
    ${TMUX} new-session -s work -d
    if [[ "${XDG_SESSION_TYPE}" == "wayland" ]]; then
      /sbin/foot -a work ${TMUX} attach -t work
    else
      /sbin/alacritty --class work -e ${TMUX} attach -t work
    fi
    ;;
esac
