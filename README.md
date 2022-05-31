# dotfiles (June 2022)
Modern dotfiles configuration that sets up the following:

 * Linux
   * i3 window manager with MATE desktop environment
   * redshift (requires separate daemonization)
   * picom compositing manager
 * Common
   * alacritty terminal
   * fish shell
   * neovim editor

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
 * neovim
 
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
 * To counter application signing issues, manually build `neovide` and `alacritty` from source.

### Linux Requirements
The packages to-be installed below are meant for Fedora.

#### Fonts
 * Fira Code Nerd Font
 * JetBrains Mono Nerd Font

#### Packages
 * git
 * make
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
 * neovim
 * python3-neovim
 * clang

#### Optional
 * moby-engine
 * moby-engine-fish-completion
 * docker-compose

#### Post-Install Notes
 * Make sure requisite [Nerd Fonts](https://www.nerdfonts.com/font-downloads) are installed
 * If `moby-engine` is installed,
   * Make sure main user can run Docker commands: see [Appendix A](https://github.com/andermatt64/dotfiles/edit/main/README.md#appendix-a)
   * Changin SELinux status requires deleting existing containers and rerunning them.
 * If building from source is not an option, we provide compiled `neovide` binaries installable via `install_neovide.sh` script in `support/`

### Additional Prerequisites
 * Install [LunarVim](https://www.lunarvim.org/01-installing.html#prerequisites)
 * Install nodejs LTS using `n`: `n lts`

### Remote LunarVim Deployment (TODO)

### Appendix A: Docker setup
<pre>
systemctl enable docker
groupadd docker
usermod -aG docker username
</pre>

### Appendix B: Building neovide on Linux aarch64 (specifically Fedora)
Install the following additional Fedora packages:
 * python2.7
 * fontconfig-devel
 * libxcb-devel
 * ninja-build

Follow the [from source build instructions](https://github.com/neovide/neovide/blob/main/README.md#from-source-1), namely steps 2 to 4. Step 4 is expected to fail with an error message about a file in `~/.cargo/registry/src/github.com-1ecc6299db9ec823/skia-bindings-0.42.1`.

Currently, `neovide` does not build on aarch64 because `rust-skia` has broken platform assumptions. The Ninja build scripts only provide x86 and amd64 binaries -- erroring out on all other platforms. To fix, we have to manually add a new platform case and make it use the `ninja` build tool from `PATH` (see below for a snippet of what we added to fix)

`~/.cargo/registry/src/github.com-1ecc6299db9ec823/skia-bindings-0.42.1/depot_tools/ninja`:
<pre>
   Linux)
     MACHINE=$(uname -m)
     case "$MACHINE" in
       i?86|x86_64)
         LONG_BIT=$(getconf LONG_BIT)
         # We know we are on x86 but we need to use getconf to determine
         # bittage of the userspace install (e.g. when running 32-bit userspace
         # on x86_64 kernel)
         exec "${THIS_DIR}/ninja-linux${LONG_BIT}" "$@";;
+      aarch64)
+        exec ninja "$@";;
       *)
         echo Unknown architecture \($MACHINE\) -- unable to run ninja.
         print_help
         exit 1;;
     esac
     ;;
   Darwin)    exec "${THIS_DIR}/ninja-mac" "$@";;
</pre>

Attempt to try step 4 again, this time, `skia-bindings` will build successfully and produce a `neovide` binary.
