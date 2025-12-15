# Keyboard bindings
# bindkey -e
bindkey -v
export KEYTIMEOUT=1
bindkey -r "\e'"
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

bindkey -M vicmd '?' history-incremental-search-backward
bindkey -M vicmd '/' history-incremental-search-forward
bindkey '^R' history-incremental-search-backward

autoload -U edit-command-line
zle -N edit-command-line
bindkey -M vicmd v edit-command-line

export VI_MODE_SET_CURSOR=true

function zle-keymap-select {
	if [[ ${KEYMAP} == vicmd ]]; then
		echo -ne '\e[2 q' # Block
	else
		echo -ne '\e[6 q' # Beam
	fi
}
zle -N zle-keymap-select

function zle-line-init {
	zle -K viins
	echo -ne '\e[6 q' # Beam
}
zle -N zle-line-init

function vi-yank-clipboard {
	zle vi-yank
	echo "$CUTBUFFER"|wl-copy -p
}

zle -N vi-yank-clipboard
bindkey -M vicmd 'y' vi-yank-clipboard
