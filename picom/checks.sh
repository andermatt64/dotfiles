#!/bin/sh

if [ "$(command -v picom 2> /dev/null)" = "" ]; then
    exit 1
fi

exit 0
