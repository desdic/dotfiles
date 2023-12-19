#!/bin/bash

selected_host=$(fuzzel --dmenu --prompt="Host: " --width=100 < ~/tmp/sshfzf.cache 2>/dev/null)
if [ -z "$selected_host" ]; then
  exit 0 
fi

if pgrep zellij >/dev/null 2>&1; then
  zellij --session work run -- zsh -c "source ~/.zshrc; ssh $selected_host"
else
  /sbin/foot /sbin/ssh "${selected_host}"
fi
