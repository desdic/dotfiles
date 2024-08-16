function mkcd take() {
  mkdir -p $@ && cd ${@:$#}
}

function set_poshcontext() {
    export BG_JOBS=$(jobs|wc -l|xargs)
}
