#!/bin/bash

for i in $(seq 1 100)
do
  gdbus call -e -d net.sourceforge.mumble.mumble -o / -m net.sourceforge.mumble.Mumble.stopTalking
done
