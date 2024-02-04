HOMEBREW_BIN := brew
NIX_BIN := nix

NIX_HOME_CONFIG := $(HOME)/.config/nix/nix.conf
NIX_GLOBAL_CONFIG := /etc/nix/nix.conf

FLAKE_TEMPLATE_DIR := ./templates
FLAKE_GENERATOR := ./scripts/generate-flake
FLAKE_TARGETS := flake.nix home.nix

all: ${FLAKE_TARGETS} 
	$(info TODO: nix run)
	
clean:
	$(info Removing ${FLAKE_TARGETS})
	-@rm ${FLAKE_TARGETS}

casks:
	$(info TODO: install casks)
	
deps_check:
ifeq ("$(shell grep "^experimental-features = nix-command flakes" $(shell test -e ${NIX_HOME_CONFIG} && echo ${NIX_HOME_CONFIG}) $(shell test -e ${NIX_GLOBAL_CONFIG} && echo ${NIX_GLOBAL_CONFIG}) /dev/null 2>/dev/null)", "")
	$(error Nix experimental flakes not enabled. Please enable flakes by following instructions here: https://nixos.wiki/wiki/Flakes)
endif
ifeq ("$(shell which brew)", "")
	$(error Homebrew is not installed. Please install Homebrew by following instructions here: https://brew.sh)
endif
ifeq ("$(shell which nix)", "")
	$(error Nix is not installed. Please install Nix for MacOS by following instructions here: https://nixos.org/download#nix-install-macos)
endif

.PHONY: all casks clean deps_check

%.nix: ${FLAKE_TEMPLATE_DIR}/%.template.nix
	$(info Generating $@ from $<)
	@${FLAKE_GENERATOR} --output $@ $<

