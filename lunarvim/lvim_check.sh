#!/bin/sh

LVIM_CONFIG_DIR="${HOME}/.config/lvim"
LVIM_BIN_PATH="$(command -v lvim)"

if [ "${LVIM_BIN_PATH}" = "" ] || [ ! -d "${LVIM_CONFIG_DIR}" ]; then
    printf "0"
    exit 1
fi

printf "1"
exit 0
