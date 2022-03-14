#!/bin/sh

REDSHIFT_PATH=$(command -v redshift 2> /dev/null)

if [ "$1" = "" ] || [ "$2" = "" ] || [ "$3" = "" ]; then
    echo "Required three arguments missing."
    exit 1
fi

if [ "${REDSHIFT_PATH}" = "" ]; then
    echo "No redshift found. Ignoring linking procedure."
    exit 0
else
    mkdir -p ${3}
    echo "Found redshift. Proceeding withing linking procedure."
    ln -s ${1} ${2}
    echo "Linking ${1} to ${2}"
fi