#!/bin/bash
set -e
QTY=${1:-10}
source utils.sh

for x in $(seq 1 $QTY); do
  MSG="$(rand_str 8)=\"$(rand_str 16)\""
  echo -e $MSG
done
