#!/bin/sh

if [ "$1" = "" ] || [ "$2" = "" ]; then
    echo "Expecting two arguments, got none"
    exit 1
fi

REPO_ROOT=$(realpath "$(dirname ${0})/..")

echo ${REPO_ROOT}