# there should be no !# since we source this script to add it to our history
local DIR=$(fd . --type directory ~/ ~/.config ~/git ~/git/cookbooks ~/src/private --maxdepth 1|fzf +m --prompt="directory > ")
  if [ -n "$ZELLIJ" ]; then
    LAYOUT=default
    if [ -f "${DIR}/Makefile" ]; then
      LAYOUT=development
    elif [ -f "${DIR}/.kitchen.yml" ]; then
      LAYOUT=kitchen
    fi

    if [ "$LAYOUT" != "default" ]; then
      zellij --session work action new-tab --cwd "$DIR" --layout ${LAYOUT}
      #let zellij handle the change of dir
      DIR=""
    fi

  elif [ -n "$TMUX" ]; then
    NAME=$(basename $DIR)
    tmux rename-window -t work "${NAME}"
  fi

if [ -n "$DIR" ]; then
    cd $DIR
fi
