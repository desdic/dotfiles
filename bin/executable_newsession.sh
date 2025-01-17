#!/bin/sh

TMUX=/usr/bin/tmux
HC=/usr/bin/hyprctl
WEZTERM=/sbin/wezterm
FOOT=/sbin/foot
ALACRITTY=/sbin/alacritty
KITTY=/sbin/kitty
GHOSTTY=/sbin/ghostty

[ ! -x ${TMUX} ] && exit 1

if [ -x ${GHOSTTY} ]; then
  ATTACH="${GHOSTTY} --class=my.work -e ${TMUX} attach -t work"
elif [ -x ${KITTY} ]; then
  ATTACH="${KITTY} --class my.work ${TMUX} attach -t work"
elif [ -x ${WEZTERM} ]; then
  ATTACH="${WEZTERM} start --class my.work --new-tab ${TMUX} attach -t work"
elif [ -x ${FOOT} ]; then
  ATTACH="${FOOT} -a my.work ${TMUX} attach -t work"
elif [ -x ${ALACRITTY} ]; then
  ATTACH="${ALACRITTY} --class my.work -e ${TMUX} attach -t work"
fi


function focus() {
  WS=$(${HC} clients -j|jq -r '.[]| select(.class=="my.work")|.workspace.id')
  if [ -n "${WS}" ]; then
    ${HC} dispatch workspace "${WS}"

    TRIES=0
    ACTIVE=$(${HC} activewindow -j|jq -r '.initialClass')
    while [[ "${ACTIVE}" != "my.work" ]]
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

# LANG=da_US.UTF-8

RES=$(${TMUX} ls -F "#{session_name}_#{?session_attached,attached,not_attached}"|grep ^work_)
echo ${RES}

case ${RES} in
  work_attached)
    focus
    ${TMUX} new-window -t work
    ;;
  work_not_attached)
    ${ATTACH}
    ;;
  *)
    ${TMUX} new-session -s work -d
    ${ATTACH}
    ;;
esac
