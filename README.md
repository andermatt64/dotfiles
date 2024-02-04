# dotfiles (February 2024)
Modern dotfiles configuration that documents and sets up my optimal development setup for MacOS and Linux.

## Overview
The main rationales behind moving to a Nix-based approach:
* **Increased efficiency:** integrated configuration management and application installation
* **Dependency isolation:** Less software version conflicts and pollution of global install.

### MacOS
Nix will be mostly used to automate the installation and configuration of command-line tools. UI-extensive applications such as terminals, browsers, etc. will still be installed via Homebrew Casks. 

### Linux
TBA
 
## Prerequisites
### MacOS
1. Enable FileVault and reboot the machine
2. Install [Homebrew](https://brew.sh)
3. Install [Nix: the package manager](https://nixos.org/download#nix-install-macos) and restart the shell
4. Enable flakes support by creating `~/.config/nix/nix.conf` with the following contents: `experimental-features = nix-command flakes`

### Linux
TBA

## Installation
1. Checkout [dotfiles](https://github.com/andermatt64/dotfiles) repository: `git clone https://github.com/andermatt64/dotfiles`
2. In the repository root directory, run `make all`. This should verify all the prerequisites are in place and run `nix run path:$(pwd) -- switch --flake path:$(pwd)`. 

## Post Install

### MacOS
1. Add `~/.nix-profile/bin/fish` to `/etc/shells`
2. Use `chsh` to switch login shell to `fish`
3. Consider manually installing [Questrial font](https://fonts.google.com/specimen/Questrial)
4. In **System Settings**:
  1. Add *Amethyst* explicitly as a **Login Item** in **System Settings**
  2. Unselect *Automatically rearrange Spaces based on most recent use* under **Mission Control** panel in **Desktop & Dock**
  3. Set *Delay until repeat* to one notch to the left of *Short* in **Keyboard**
  4. Ensure *Switch to Desktop &lt;N&gt;* is enabled and mapped to *Alt-&lt;N&gt;* under **Mission Control** in **Keyboard Shortcuts** 
5. For `wezterm` to have nice font-smoothing, consider running the following commands:
<pre>
defaults write -g CGFontRenderingFontSmoothingDisabled -bool NO
defaults -currentHost write -globalDomain AppleFontSmoothing -int 2
</pre>

### Linux
TBA
