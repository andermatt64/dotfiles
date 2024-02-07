# dotfiles (February 2024)
Modern dotfiles configuration that documents and sets up my optimal development setup for MacOS and Linux.

## Overview
The main rationale behind moving to a Nix-based approach:
* **Increased efficiency:** Integrated configuration management and application installation
* **Dependency isolation:** Less software version conflicts and pollution of global install.
* **Easier customization:** Popular tools are automatically set up close to our preferences.
* **Development shells:** No need to pollute global packages, setup tailored development "containers"

Nix will be used to automate the installation and configuration of command-line tools. UI-extensive applications such as terminal emulators, browsers, etc. will be installed via either Homebrew Casks (MacOS), Flatpak (Linux), or Snaps (Ubuntu).
 
## Prerequisites
### MacOS
1. Set a hostname for the machine using _System Settings_ and via the following command: `sudo scutil --set HostName <HOSTNAME>`
2. Enable *FileVault* and reboot the machine
3. Install [Homebrew](https://brew.sh)
4. For Nix installer, we recommend using the [Determinate Systems Nix installer](https://determinate.systems/posts/determinate-nix-installer) with default Nix flakes support and a MacOS updates survival mode. For instructions on using the official Nix installer, see [Appendix A](#appendix-a-official-nix-installer)

#### Appendix A: Official Nix Installer
1. Install [Nix: the package manager](https://nixos.org/download#nix-install-macos) and restart the shell
2. Enable flakes support by creating `~/.config/nix/nix.conf` with the following contents: `experimental-features = nix-command flakes`
<pre>
mkdir -p ~/.config/nix
echo experimental-features = nix-command flakes > ~/.config/nix/nix.conf
</pre>

### Linux
Support for immutable distros TBA

## Installation
1. Checkout [dotfiles](https://github.com/andermatt64/dotfiles) repository: `git clone https://github.com/andermatt64/dotfiles`
2. In a terminal, change the current directory into the repository root, `dotfiles`
3. Run `make` -- this should verify all the prerequisites are in place and run `nix run path:$(pwd) -- switch --flake path:$(pwd)`. 

## Post Install
### MacOS
> **Note:** We do not add `fish` to `/etc/shells` nor set it as the default shell for the main user anymore. This is so that we have an emergency shell to quickly fall back on in the event that a MacOS update breaks Nix store. 

1. Start a new shell and run `make casks` to install Homebrew Casks.
2. Consider manually installing [Questrial font](https://fonts.google.com/specimen/Questrial)
3. In **System Settings**:
    1. Add *Amethyst* explicitly as a **Login Item** in **System Settings**
    2. Unselect *Automatically rearrange Spaces based on most recent use* under **Mission Control** panel in **Desktop & Dock**
    3. Ensure *Switch to Desktop &lt;N&gt;* is enabled and mapped to *Alt-&lt;N&gt;* under **Mission Control** in **Keyboard Shortcuts** 
    4. Set *Delay until repeat* to one notch to the left of *Short* in **Keyboard**
    5. Set *Key repeat rate* to the notch under *Fast* in **Keyboard**
    6. Set *Natural scrolling* to **ON** in **Mouse**
4. In the **Shortcuts** tab pane under *Amethyst Settings*, clear the following shortcuts:
    * **Move focus to main window**
    * **Move focus to counter clockwise screen**
    * **Move focus to clockwise screen**
    * **Swap focused window to counter clockwise screen**
    * **Swap focused window to clockwise screen**
    * **Swap focused window with main window**
    * **Focus screen &lt;N&gt;**
    * **Throw focused window to screen &lt;N&gt;**
    * **Toggle focus follows mouse**
    * **Toggle global tiling**
    * **Select Tall layout**
    * **Select Wide layout**
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

## MacOS Update Recovery
In the event a MacOS update breaks Nix store, the following steps should alleviate most issues:

Make sure `/etc/zshrc` ends with the following stanza:
<pre>
# Nix
if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
  . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
fi
# End Nix
</pre>

Make sure `/etc/synthetic.conf` contains the content: `nix`
