#!/bin/bash

CONFIG="$HOME/git/chef-repo $HOME/.ssh/known_hosts"
mkdir -p "$HOME/tmp"

while true; do
  (~/git/chef-repo/scripts/cnodes ; awk '{print $1}' ~/.ssh/known_hosts) |sort|uniq > "$HOME/tmp/sshfzf.cache"
  inotifywait -e create,modify,delete -r ${CONFIG}
  sleep 2
done
