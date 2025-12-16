autoload -Uz vcs_info
autoload -U colors && colors
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git*' formats " %F{blue} %b%u%c%f"
zstyle ':vcs_info:git:*' stagedstr '%F{yellow} ●%f'
zstyle ':vcs_info:git:*' stashedstr '%F{cyan} ⚑%f'
zstyle ':vcs_info:git:*' unstagedstr '%F{green} ~%f'
zstyle ':vcs_info:git:*' actionformats '(%b|%a%u%c)'

# Enable substitution in the prompt.
setopt prompt_subst

precmd() {
    local num_jobs=$(jobs -p | wc -l)
    if (( num_jobs > 0 )); then
        JOBS_DISPLAY=" [$num_jobs]"
    else
        JOBS_DISPLAY=""
    fi
    vcs_info
}

# Config for the prompt. PS1 synonym.
prompt='%F{blue} %n%f %F{magenta}%~%f${vcs_info_msg_0_}%F{green}$JOBS_DISPLAY%f%(?.%F{green} >%f.%F{red} ✘%f) '
