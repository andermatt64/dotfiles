#!/bin/sh

PICOM_BIN=$(command -v picom)

if [ "${PICOM_BIN}" = "" ]; then
    printf "0"
    exit 1
fi

printf "1"
exit 0

