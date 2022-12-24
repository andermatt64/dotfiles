# dotfiles (December 2022)
Modern dotfiles configuration that documents and sets up my optimal setup for MacOS and Linux.

### MacOS Requirements
All packages require first installing [Homebrew](https://brew.sh) and installing the `homebrew/cask-fonts` tap using the following command:
<pre>
brew tap homebrew/cask-fonts
</pre>

#### Packages
 * fish
 * jq
 * starship
 * n
 * ripgrep
 * neovim
 * exa
 * bat
 * sox
 * tmux

#### Casks
 * miniforge
 * blender
 * amethyst
 * font-jetbrains-mono-nerd-font
 * font-fira-code-nerd-font
 * font-ubuntu-mono-nerd-font
 * font-hack-nerd-font

#### Optional
 * alacritty (recommend building from source)
 * neovide (recommend building from source)
 * rustup-init
 * golang
 
#### Post-Install Notes
 * Make sure to add `/opt/homebrew/bin/fish` to `/etc/shells`
 * To counter application signing issues, manually build `neovide` and `alacritty` from source.
 * For `alacritty` to have nice font-smoothing, run the following commands:
<pre>
defaults write -g CGFontRenderingFontSmoothingDisabled -bool NO
defaults -currentHost write -globalDomain AppleFontSmoothing -int 2
</pre>
 * [Setup Amethyst with an i3-like experience](amethyst/README.md)

### Linux Requirements
The packages to-be installed below are meant for Fedora.

#### Fonts
 * Fira Code Nerd Font
 * JetBrains Mono Nerd Font
 * Hack Nerd Font
 * Ubuntu Mono Nerd Font

#### Core Packages
 * git
 * make
 * fish
 * jq
 * starship (requires [COPR](https://copr.fedorainfracloud.org/coprs/atim/starship/))
 * ripgrep
 * neovim
 * python3-neovim
 * clang
 * exa
 * bat
 * sox
 * tmux

#### UI Packages
 * fira-code-fonts
 * xclip
 * xprop
 * java-17-openjdk
 * bismuth
 * alacritty (sometimes requires [COPR](https://copr.fedorainfracloud.org/coprs/atim/alacritty/) for latest versions)
 * neovide (may not work on Linux aarch64)
 
#### Optional
 * moby-engine
 * moby-engine-fish-completion
 * docker-compose

#### Post-Install Notes
 * Make sure requisite [Nerd Fonts](https://www.nerdfonts.com/font-downloads) are installed
 * If `moby-engine` is installed,
   * Make sure main user can run Docker commands: see [Appendix A](https://github.com/andermatt64/dotfiles/blob/main/README.md#appendix-a)
   * Changing SELinux status requires deleting existing containers and rerunning them.
 * To setup KDE with Bismuth, take a look at [KDE Bismuth setup for an i3-like experience](kde/README.md)

### Additional Prerequisites
 * Install nodejs LTS using [`n`](https://github.com/tj/n): `n lts`
 * Install [LunarVim](https://www.lunarvim.org/docs/installation) (unsupported dependencies on Linux aarch64)

### Remote LunarVim Deployment (TODO)
To be continued...

### Appendix A: Docker setup
The `docker` group is usually created after installing `moby-engine`. However, we need to run the following commands to add the proper users and enable automatic startup on reboot.
<pre>
systemctl enable docker
usermod -aG docker $USER
</pre>

