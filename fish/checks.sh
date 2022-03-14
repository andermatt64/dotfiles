#!/bin/sh

PLATFORM=$(uname)

if [ "${PLATFORM}" = "Darwin" ] && [ -f /opt/homebrew/bin/fish ]; then
    printf "1"
    exit 0
elif [ "${PLATFORM}" = "Linux" ] && [ -f /usr/bin/fish ]; then
    printf "1"
    exit 0
fi

printf "0"
exit 1