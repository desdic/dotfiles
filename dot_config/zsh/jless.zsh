
function jless() {
  local IN=/dev/stdin
  if [ -n "${1}" ]; then
    IN=$1
  fi
  jq -C '.' $IN | less -r
}
