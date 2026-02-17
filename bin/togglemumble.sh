#!/bin/bash

# Check if Mumble is running
if ! pgrep -x "mumble" >/dev/null; then
  echo "Mumble is not running."
  exit 1
fi

mumble rpc unmute
mumble rpc undeaf

STATE=$(tail -1 /tmp/mumble.state)

if [ "$STATE" == "off" ]; then
  gdbus call -e -d net.sourceforge.mumble.mumble -o / -m net.sourceforge.mumble.Mumble.startTalking
  echo "on" > /tmp/mumble.state
else
  ~/bin/stopmumble.sh
  echo "off" > /tmp/mumble.state
fi
