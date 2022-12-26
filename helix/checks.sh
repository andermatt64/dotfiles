#!/bin/bash

HELIX_BIN_PATH=$(command -v hx)

if [ ! "${HELIX_BIN_PATH}" = "" ]; then
  printf "1"
  exit 0
fi

printf "0"
exit 1  
