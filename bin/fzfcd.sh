# there should be no !# since we source this script to add it to our history
DIR=$(fd . --type directory ~/ ~/.config ~/git ~/git/cookbooks ~/src/private --maxdepth 1|fzf +m --prompt="directory > ")
if [ -n "$DIR" ]; then
  NAME=$(basename "$DIR")

  if [ -n "$WEZTERM_PANE" ]; then
    /sbin/wezterm cli set-tab-title "${NAME}"
  elif [ -n "$ZELLIJ" ]; then
    zellij --session work action rename-tab "$NAME"
  elif [ -n "$TMUX" ]; then
    tmux rename-window -t work "${NAME}"
  fi

  if [ -n "$DIR" ]; then
    cd "$DIR"
  fi
fi
