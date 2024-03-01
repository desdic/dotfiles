#!/bin/bash

/sbin/grim -g "$(/sbin/slurp)" - | /sbin/swappy -f -
