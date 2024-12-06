
function ef() {
    /sbin/fzf | /sbin/xargs /sbin/zsh -c '</dev/tty $EDITOR "$@"' ignoreme
}

function fcd() {
  dir=$(/sbin/fzf +m|/sbin/xargs /sbin/dirname) && cd "$dir"
  # dir=$(find ${1:-.} -type d -path ./.cache -prune -o -print 2> /dev/null | fzf +m) && cd "$dir"
}

function fzgrep() {
  /sbin/grep --line-buffered --color=never -r "" * | fzf
}

if [ -x /sbin/fzf ]; then
  if [ -x /sbin/fd ]; then
    export FZF_DEFAULT_COMMAND='fd --type f'
  elif [ -x /sbin/ag ]; then
    export FZF_DEFAULT_COMMAND="ag --hidden --ignore .git -f -g ''"
  else
    export FZF_DEFAULT_COMMAND="find -L"
  fi
fi
