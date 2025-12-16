export LANG=en_DK.UTF-8

export BROWSER=/sbin/google-chrome-stable
export LESS=-Xr

export EDITOR="nvim"
export VISUAL="${EDITOR}"
export FCEDIT="${EDITOR}"
alias view="${EDITOR} -M"

export LSCOLORS="Exfxcxdxbxegedabagacad"

export TERMINAL='kitty'

export SSH_AUTH_SOCK="${XDG_RUNTIME_DIR}/ssh-agent.socket"
export GPG_TTY=$(tty)
