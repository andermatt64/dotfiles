#!/bin/sh

REPO_ROOT=$(cd "$(dirname "$0")"; pwd -P)
NEOVIDE_VERSION="0.8.0"

DISTRO_NAME=$(awk -F= '$1=="ID" { print $2 ;}' /etc/os-release)
DISTRO_VERSION=$(awk -F= '$1=="VERSION_ID" { print $2 ;}' /etc/os-release)
PLATFORM=$(uname -p)

NEOVIDE_BIN="neovide-${NEOVIDE_VERSION}-${DISTRO_NAME}${DISTRO_VERSION}-${PLATFORM}"

PKG_NAME="pkg-${NEOVIDE_BIN}.tar.xz"
PKG_DIR="${REPO_ROOT}/binaries"

TARGET_DIR="${HOME}/.local/bin"
TARGET_BIN="${TARGET_DIR}/neovide"

if [ ! -f "${PKG_DIR}/${PKG_NAME}" ]; then
  printf "[error] Failed to find neovide package for ${DISTRO_NAME}${DISTRO_VERSION} on ${PLATFORM}\n"
  exit 1
fi

if [ -f "${PKG_DIR}/${NEOVIDE_BIN}" ]; then
  printf "[info] Skipping extraction -- ${PKG_NAME} already extracted.\n"
else
  printf "[info] Extracting ${PKG_NAME} to ${PKG_DIR}...\n"

  tar xf "${PKG_DIR}/${PKG_NAME}" -C "${PKG_DIR}"
fi

if [ -f "${TARGET_BIN}" ]; then
  printf "[info] Found existing symlink at ${TARGET_BIN}, removing...\n"
  rm -f "${TARGET_BIN}"
fi

printf "[info] Creating symlink: ${TARGET_BIN} => ${PKG_DIR}/${NEOVIDE_BIN}\n"
ln -s "${PKG_DIR}/${NEOVIDE_BIN}" "${TARGET_BIN}"
