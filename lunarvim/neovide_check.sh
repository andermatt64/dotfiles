#!/bin/sh

PLATFORM=$(uname)
NEOVIDE_BIN_PATH="$(command -v neovide)"

if [ "${PLATFORM}" = "Linux" ]; then
  if [ "${NEOVIDE_BIN_PATH}" = "" ]; then
      printf "0"
      exit 1
  fi
  
  printf "1"
  exit 0
elif [ "${PLATFORM}" = "Darwin" ]; then
  if [ -f /Applications/Neovide.app/Contents/MacOS/neovide ] || [ -f ~/Applications/Neovide.app/Contents/MacOS/neovide ]; then
    printf "1"
    exit 0
  fi

  printf "0"
  exit 1
else
  # Unknown platform, be safe and return not found
  printf "0"
  exit 1
fi
