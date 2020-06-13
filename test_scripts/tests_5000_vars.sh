#!/bin/bash
set -e
cd ../
INCLUDE_VAR_NAMES=0 ./example.sh test_vars_5000_random_vars.sh $@
