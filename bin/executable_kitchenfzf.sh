#!/usr/bin/env bash

suites=( $(kitchen list --bare 2>/dev/null|tr '\n' ' ') )
targets=$1
if [ -z "$1" ]; then
  targets=( converge test login verify destroy )
else
  targets=("$1")
fi

list=()
for key in "${suites[@]}"
do
  for target in "${targets[@]}"
  do
    list+=("kitchen $target $key")
  done
done

printf -v joined '%s,' "${list[@]}"
choice=$(echo "$joined"|tr ',' '\n'|fzf +m)
if [ -n "$choice" ]; then
  eval "$choice"
fi
