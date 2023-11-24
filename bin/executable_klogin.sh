#!/bin/bash

DIST="*"

if [ -n "$1" ]; then
  DIST="$1"
fi

for config in $(find . -type f -iname "build-systems-${DIST}.yml"|sort -r)
do
  echo "logging into $config"
  HOSTNAME=$(grep hostname: "${config}"|awk '{print $2}')
  PORT=$(grep port: "${config}"|awk '{print $2}')
  USERNAME=$(grep username: "${config}"|awk '{print $2}')
  SSHKEY=$(grep ssh_key: "${config}"|awk '{print $2}'|sed 's/"//g')

  ssh -o StrictHostKeyChecking=no "${HOSTNAME}" -p "${PORT}" -l "${USERNAME}" -i "${SSHKEY}"
  break
done
