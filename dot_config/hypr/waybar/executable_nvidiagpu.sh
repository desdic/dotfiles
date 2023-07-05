#!/bin/bash

/sbin/nvidia-smi --query-gpu=temperature.gpu,utilization.gpu,utilization.memory --format=csv,noheader,nounits | sed -ur 's|([[:digit:]]+)[^[:digit:]]*([[:digit:]]+)[^[:digit:]]*([[:digit:]]+)|GPU \1°|g'
