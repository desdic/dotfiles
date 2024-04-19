#!/bin/sh

TMUX=/usr/bin/tmux
HC=/usr/bin/hyprctl

[ ! -x ${TMUX} ] && exit 1

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

LANG=da_US.UTF-8

RES=$(${TMUX} ls -F "#{session_name}_#{?session_attached,attached,not_attached}"|grep ^work_)

case ${RES} in
  work_attached)
    focus
    ${TMUX} new-window -a -t work
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
