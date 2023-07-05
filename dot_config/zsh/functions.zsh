function mkcd take() {
  mkdir -p $@ && cd ${@:$#}
}
