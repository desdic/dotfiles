function mkcd take() {
  mkdir -p $@ && cd ${@:$#}
}

function set_poshcontext() {
    export BG_JOBS=$(jobs|wc -l|xargs)
}

function highlight() {
    /usr/bin/grep -E --color=auto "$@|";
}

function mman() {
	man $1 | bat -l man --style=-numbers
}
