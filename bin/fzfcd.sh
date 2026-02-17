# there should be no !# since we source this script to add it to our history
DIR=$(fd . --type directory --type symlink ~/ ~/.config ~/git ~/src/private --maxdepth 1|fzf +m --prompt="directory > " --query="$1")
if [ -n "$DIR" ]; then

  NAME=$(basename $DIR)
  if [ -n "$TMUX" ]; then
    tmux rename-window "${NAME}"
  fi

  if [ -n "$DIR" ]; then
    cd $DIR
  fi

fi
