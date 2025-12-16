unsetopt share_history
unsetopt AUTO_CD

# Disable build-in r
disable r

# Turn ctrl+s/ctrl+q off
setopt noflowcontrol
stty stop undef
stty start undef

export WORDCHARS=''
autoload -U select-word-style
select-word-style bash
