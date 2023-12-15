selected_host=$({ ~/git/chef-repo/scripts/cnodes & awk '{print $1}' ~/.ssh/known_hosts; }|sort|uniq|fzf +m --query "$LBUFFER" --prompt="SSH remote > " --color "prompt:#89b4fa")
if [ -z "$selected_host" ]; then
  exit 0
fi

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
