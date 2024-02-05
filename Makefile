HOMEBREW_BIN := brew
NIX_BIN := nix
NIXENV_BIN := nix-env
NIXSTORE_BIN := nix-store

NIX_HOME_CONFIG := $(HOME)/.config/nix/nix.conf
NIX_GLOBAL_CONFIG := /etc/nix/nix.conf

BREW_CASK_TARGETS := amethyst dbeaver-community firefox google-chrome wezterm

FLAKE_TEMPLATE_DIR := ./templates
FLAKE_GENERATOR := ./scripts/generate-flake
FLAKE_TARGETS := flake.nix home.nix

all: deps_check ${FLAKE_TARGETS} 
	$(info Building and switching to new nix home-manager configuration...)
	@${NIX_BIN} run path:$(shell pwd) -- switch --flake path:$(shell pwd)

build: deps_check ${FLAKE_TARGETS}
	$(info Building nix home-manager configuration...)
	@${NIX_BIN} run path:$(shell pwd) -- build --flake path:$(shell pwd)
	 
clean:
	$(info Removing ${FLAKE_TARGETS})
	-@rm ${FLAKE_TARGETS}

casks: macos_deps_check
	$(info Installing Homebrew casks: ${BREW_CASK_TARGETS})
	@brew install ${BREW_CASK_TARGETS}

gc:
	$(info Running nix garbage collection on old generations...)
	@${NIXENV_BIN} --delete-generations old
	@${NIXSTORE_BIN} --gc

macos_deps_check:
ifeq ("$(shell which brew)", "")
	$(error Homebrew is not installed. Please install Homebrew by following instructions here: https://brew.sh)
endif

deps_check:
ifeq ("$(shell which nix)", "")
	$(error Nix is not installed. Please install Nix for MacOS by following instructions here: https://nixos.org/download#nix-install-macos)
endif
ifeq ("$(shell grep "^experimental-features = nix-command flakes" $(shell test -e ${NIX_HOME_CONFIG} && echo ${NIX_HOME_CONFIG}) $(shell test -e ${NIX_GLOBAL_CONFIG} && echo ${NIX_GLOBAL_CONFIG}) /dev/null 2>/dev/null)", "")
	$(error Nix experimental flakes not enabled. Please enable flakes by following instructions here: https://nixos.wiki/wiki/Flakes)
endif

.PHONY: all build casks clean deps_check gc macos_deps_check

%.nix: ${FLAKE_TEMPLATE_DIR}/%.template.nix
	$(info Generating $@ from $<)
	@${FLAKE_GENERATOR} --output $@ $<

