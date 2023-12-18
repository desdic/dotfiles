selected_host=$(cat $HOME/tmp/sshfzf.cache|sort|uniq|fzf +m --query "$LBUFFER" --prompt="SSH remote > " --color "prompt:#89b4fa")
if [ -n "$selected_host" ]; then
  if [ -n "$TMUX" ]; then
    WINDOWNAME=$(echo "${selected_host}"|cut -d . -f1)
    tmux rename-window -t work "${WINDOWNAME}"
  elif [ -n "$ZELLIJ" ]; then
    zellij action rename-tab "${selected_host}"
    zellij action rename-pane "${selected_host}"
  fi

  # add to zsh history
  print -s ssh "${selected_host}"
  ssh "${selected_host}"
fi

