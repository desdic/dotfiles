export FZF_DEFAULT_COMMAND='fd --type f --hidden --strip-cwd-prefix'

# Make Ctrl-T use the same custom fd command
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

#  --layout=reverse not sure I like the reverse list
export FZF_DEFAULT_OPTS='
  --height=60%
  --border=rounded
  --prompt="  "
  --pointer="  "
  --preview-window=right:65%:wrap:border-left
'

export _FZF_PREVIEW_CMD='bat --color=always --style=plain,numbers --line-range=:500 {}'
export FZF_CTRL_T_OPTS="--preview '$_FZF_PREVIEW_CMD'"

# load fzf's zsh
if (( $+commands[fzf] )); then
  source <(fzf --zsh)
fi

# Ctrl+F file picket
_fzf_file_no_hidden() {
  local cmd result
  cmd="${FZF_DEFAULT_COMMAND/--hidden /}"
  result=$(eval "${cmd:-find . -type f}" | fzf --preview "$_FZF_PREVIEW_CMD") \
    && LBUFFER+="$result"
  zle reset-prompt
}
zle -N _fzf_file_no_hidden

# Bind Ctrl+F to your custom widget
bindkey '^F' _fzf_file_no_hidden

_fzf_to_nvim() {
  local file
  file=$(eval "$FZF_DEFAULT_COMMAND" | fzf --preview "$_FZF_PREVIEW_CMD")
  
  # If a file was selected, open it in nvim
  if [[ -n "$file" ]]; then
    # zle -I tells Zsh to pause the line editor so Neovim can take over the terminal cleanly
    zle -I
    nvim "$file"
  fi
  zle reset-prompt
}
zle -N _fzf_to_nvim

# Bind Ctrl+V
bindkey '^V' _fzf_to_nvim
