#!/bin/sh

NEOVIDE_BIN_PATH="$(command -v neovide)"

if [ "${NEOVIDE_BIN_PATH}" = "" ]; then
    printf "0"
    exit 1
fi

printf "1"
exit 0
