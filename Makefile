HOMEBREW_BIN := brew
NIX_BIN := nix

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
ifeq ("$(shell which brew)", "")
	$(error Homebrew is not installed. Please install Homebrew by following instructions here: https://brew.sh)
endif
ifeq ("$(shell which nix)", "")
	$(error Nix is not installed. Please install Nix for MacOS by following instructions here: https://nixos.org/download#nix-install-macos)
endif
ifeq ("$(shell grep "^experimental-features = nix-command flakes" $(HOME)/.config/nix/nix.conf /etc/nix/nix.conf 2>/dev/null) ", "")
	$(error Nix experimental flakes not enabled. Please enable flakes by following instructions here: https://nixos.wiki/wiki/Flakes)
endif

.PHONY: all casks clean deps_check

%.nix: ${FLAKE_TEMPLATE_DIR}/%.template.nix
	$(info Generating $@ from $<)
	@${FLAKE_GENERATOR} --output $@ $<

