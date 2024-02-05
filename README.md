# dotfiles (February 2024)
Modern dotfiles configuration that documents and sets up my optimal development setup for MacOS and Linux.

## Overview
The main rationale behind moving to a Nix-based approach:
* **Increased efficiency:** integrated configuration management and application installation
* **Dependency isolation:** Less software version conflicts and pollution of global install.
* **Easier customization:** Popular tools are automatically set up close to our preferences.

### MacOS
Nix will be mostly used to automate the installation and configuration of command-line tools. UI-extensive applications such as terminals, browsers, etc. will still be installed via Homebrew Casks. 

### Linux
TBA
 
## Prerequisites
### MacOS
1. Set a hostname for the machine
2. Enable *FileVault* and reboot the machine
3. Install [Homebrew](https://brew.sh)
4. Install [Nix: the package manager](https://nixos.org/download#nix-install-macos) and restart the shell
5. Enable flakes support by creating `~/.config/nix/nix.conf` with the following contents: `experimental-features = nix-command flakes`
<pre>
mkdir -p ~/.config/nix
echo experimental-features = nix-command flakes > ~/.config/nix/nix.conf
</pre>

### Linux
TBA

## Installation
1. Checkout [dotfiles](https://github.com/andermatt64/dotfiles) repository: `git clone https://github.com/andermatt64/dotfiles`
2. In a terminal, change the current directory into the repository root, `dotfiles`
3. Run `make` -- this should verify all the prerequisites are in place and run `nix run path:$(pwd) -- switch --flake path:$(pwd)`. 
4. On a MacOS machine, start a new session and run `make casks` to install Homebrew casks.

## Post Install
### MacOS
1. Add `~/.nix-profile/bin/fish` to `/etc/shells`: `echo ${HOME}/.nix-profile/bin/fish | sudo tee -a /etc/shells`
2. Use `chsh` to switch login shell to `fish`
3. Consider manually installing [Questrial font](https://fonts.google.com/specimen/Questrial)
4. In **System Settings**:
    1. Add *Amethyst* explicitly as a **Login Item** in **System Settings**
    2. Unselect *Automatically rearrange Spaces based on most recent use* under **Mission Control** panel in **Desktop & Dock**
    3. Set *Delay until repeat* to one notch to the left of *Short* in **Keyboard**
    4. Ensure *Switch to Desktop &lt;N&gt;* is enabled and mapped to *Alt-&lt;N&gt;* under **Mission Control** in **Keyboard Shortcuts** 
5. In the **Shortcuts** tab pane under *Amethyst Settings*, clear the following shortcuts:
    * **Move focus to main window**
    * **Move focus to counter clockwise screen**
    * **Move focus to clockwise screen**
    * **Swap focused window to counter clockwise screen**
    * **Swap focused window to clockwise screen**
    * **Swap focused window with main window**
    * **Focus screen &lt;N&gt;**
    * **Throw focused window to screen &lt;N&gt;**
    * **Select Tall layout**
    * **Select Wide layout**
    * **Select Fullscreen layout**
    * **Select Column layout**

### Linux
TBA

### Rust Toolchain Installation
Install and set the default toolchain to be **stable**:
<pre>
rustup default stable
</pre>

Install **rust-analyzer**:
<pre>
rustup component add rust-analyzer
</pre>

## Updating Packages
Update packages by running the following command:
<pre>
make update
</pre>

## Garbage Collection
Occasionally, Nix store grows quite large because of orphaned packages. Use
<pre>
make gc
</pre>
to clean up.
