# dotfiles (March 2022)
Modern dotfiles configuration that sets up the following:
 * MacOS
   * Alacritty Terminal
 * Linux
   * i3 Hybrid Setup with MATE
   * Redshift (requires separate daemonization)
   * Picom 
   * Alacritty Terminal
   * Fish

### MacOS Requirements
All packages require first installing [Homebrew](https://brew.sh) and installing the `homebrew/cask-fonts` tap using the following command:
<pre>
brew tap homebrew/cask-fonts
</pre>

#### Normal Packages
 * fish
 * jq
 * starship
 * n
 * ripgrep
 
#### Casks
 * miniforge
 * blender
 * amethyst
 * font-jetbrains-mono-nerd-font
 * font-fira-code-nerd-font
 * font-ubuntu-mono-nerd-font
 * font-hack-nerd-font

#### Post-Install Notes
 * Make sure to add `/opt/homebrew/bin/fish` to `/etc/shells`

### Linux Requirements
The packages to-be installed below are meant for Fedora.

#### Strongly Recommended
 * git
 * i3-gaps
 * fish
 * chromium
 * fira-code-fonts
 * nitrogen
 * picom
 * xprop
 * jq
 * java-17-openjdk
 * starship
 * ripgrep

#### Optional
 * moby-engine
 * moby-engine-fish-completion
 * docker-compose

#### Post-Install Notes
 * Make sure requisite [Nerd Fonts](https://www.nerdfonts.com/font-downloads) are installed
 * If `moby-engine` is installed,
   * Make sure main user can run Docker commands: see [Appendix A](https://github.com/andermatt64/dotfiles/edit/main/README.md#appendix-a)
   * Changin SELinux status requires deleting existing containers and rerunning them.

### Appendix A
<pre>
systemctl enable docker
groupadd docker
usermod -aG docker username
</pre>
