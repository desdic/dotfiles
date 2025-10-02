autoload -Uz vcs_info
autoload -U colors && colors
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git*' formats " %F{blue} %b%f"

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
