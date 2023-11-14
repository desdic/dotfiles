#!/bin/bash

DIST=$1
DISTS=(jammy focal)
CONFIG=

if [[ -z ${DIST} ]]; then
  for DIST in "${DISTS[@]}"; do
    CONFIG=kitchen-build/.kitchen/build-systems-${DIST}.yml
    if [[ -e ${CONFIG} ]]; then
      echo "${DIST} exists"
    fi

  done
else
  CONFIG=kitchen-build/.kitchen/build-systems-${DIST}.yml
fi

if [[ ! -e ${CONFIG} ]]; then
  echo "${CONFIG} does not exist"
  exit 1
fi

HOSTNAME=$(grep hostname "${CONFIG}"|awk '{print $2}')
PORT=$(grep port "${CONFIG}"|awk '{print $2}')
USERNAME=$(grep username "${CONFIG}"|awk '{print $2}')
SSHKEY=$(grep ssh_key "${CONFIG}"|awk '{print $2}'|sed 's/"//g')

ssh "${HOSTNAME}" -p "${PORT}" -l "${USERNAME}" -i "${SSHKEY}"
