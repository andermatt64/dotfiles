# dotfiles (February 2024)
Modern dotfiles configuration that documents and sets up my optimal development setup for MacOS and Linux.

## Overview
The main rationales behind moving to a Nix-based approach:
* **Increased efficiency:** integrated configuration management and application installation
* **Dependency isolation:** Less software version conflicts and pollution of global install.

### MacOS
Nix will be mostly used to automate the installation and configuration of command-line tools. UI-extensive applications such as terminals, browsers, etc. will still be installed via Homebrew Casks. 

### Linux
TBC
 
## Prerequisites
### MacOS
1. Enable FileVault and reboot the machine
2. Install [Homebrew](https://brew.sh)
3. Install [Nix: the package manager](https://nixos.org/download#nix-install-macos) and restart the shell
4. Enable flakes by creating `~/.config/nix/nix.conf` with the following contents: `experimental-features = nix-command flakes`

### Linux
TBC

