# History
HISTFILE=~/.zsh_history
HISTSIZE=5000
SAVEHIST=${HISTSIZE}
KEYTIMEOUT=1
HISTDUPE=erase
setopt appendhistory
#setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups
