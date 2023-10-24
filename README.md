# dotfiles (February 2023)
Modern dotfiles configuration that documents and sets up my optimal setup for MacOS and Linux.

### MacOS Requirements
All packages require first installing [Homebrew](https://brew.sh) and installing the `homebrew/cask-fonts` tap using the following command:
```
brew tap homebrew/cask-fonts
```

#### Packages
 * fish
 * jq
 * starship
 * ripgrep
 * exa
 * bat
 * tmux
 * helix
 * hexyl

#### Casks
 * wezterm
 * amethyst
 * font-jetbrains-mono-nerd-font

#### Optional
 * n
 * sox
 * btop
 * miniforge
 * blender
 * rustup-init
 * golang
 * lima
 * ruby

 #### Optional (Docker)
 * colima
 * docker
 * docker-compose
 * docker-buildx
 
#### Post-Install Notes
 * Make sure to add `/opt/homebrew/bin/fish` to `/etc/shells`
 * For `wezterm` to have nice font-smoothing, run the following commands:
```
defaults write -g CGFontRenderingFontSmoothingDisabled -bool NO
defaults -currentHost write -globalDomain AppleFontSmoothing -int 2
```
 * [Setup Amethyst with an i3-like experience](amethyst/README.md)
 * Make sure to explicitly add Amethyst as a **Login Item**
 * To make `hostname` return the correct value,
 ```
 sudo scutil --set HostName <YOUR_HOSTNAME>
 ```
 
### Linux Requirements
The packages to-be installed below are meant for Fedora.

#### Fonts
 * JetBrains Mono Nerd Font

#### Core Packages
 * git
 * make
 * fish
 * jq
 * starship (requires [COPR](https://copr.fedorainfracloud.org/coprs/atim/starship/))
 * ripgrep
 * clang
 * exa
 * bat
 * sox
 * tmux
 * helix (requires [COPR](https://copr.fedorainfracloud.org/coprs/varlad/helix/))
 * hexyl

#### UI Packages
 * xclip
 * xprop
 * bismuth
 * wezterm (recommend using [FlatPak package](https://wezfurlong.org/wezterm/install/linux.html))
 
#### Optional Packages
 * fira-code-fonts
 * java-17-openjdk

#### Optional (Docker)
 * moby-engine
 * moby-engine-fish-completion
 * docker-compose

#### Language Servers Localizations for Helix
The default LSP configurations don't always match in-line with what I want. For those cases, we have `languages.toml` to use custom LSPs.
 * **\[Python\]** pyright: `npm install -g pyright`

For better web development code formatting, use `npm install -g prettier` to install Prettier.

For better Python code formatting, use `conda install -n base black` to install Black.

For Rust, `rustup` is the preferred way to install `rust-analyzer`
 * `rustup component add rust-analyzer`

#### Post-Install Notes
 * Make sure requisite [Nerd Fonts](https://www.nerdfonts.com/font-downloads) are installed
 * If `moby-engine` is installed,
   * Make sure main user can run Docker commands: see [Appendix A](https://github.com/andermatt64/dotfiles/blob/main/README.md#appendix-a)
   * Changing SELinux status requires deleting existing containers and rerunning them.
 * To setup KDE with Bismuth, take a look at [KDE Bismuth setup for an i3-like experience](kde/README.md)

### Additional Prerequisites
 * Install nodejs LTS using [`n`](https://github.com/tj/n): `n lts`

### Local Modifications
Modifications specific to a specific machines may be required to make things work best. 

To insert local modifications (other than `wezterm`):
 1. Create a `local/` directory in the repository root directory. Git will ignore this directory.
 2. Create a `[appname].local.sh` shell script that takes in the parameter of the generated configuration file path. `[appname]` should refer to the application to be localized. For example, for Alacritty, this will be `alacritty`

For localized `wezterm` configurations:
 1. Create a `local/` directory in the repository root directory (if not existing already). Git will ignore this directory.
 2. Create a `wezterm.local.lua` script that returns a table with overridden platform specific keys such as `font_size` and `line_height`

For examples of localized modifications, see [examples/](examples/)

### Appendix A: Docker setup
The `docker` group is usually created after installing `moby-engine`. However, we need to run the following commands to add the proper users and enable automatic startup on reboot.
```
systemctl enable docker
usermod -aG docker $USER
```

