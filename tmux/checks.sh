#!/bin/sh

TMUX_BIN=$(command -v tmux)

if [ "${TMUX_BIN}" = "" ]; then
    printf "0"
    exit 1
fi

printf "1"
exit 0

