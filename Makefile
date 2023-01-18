PYTHON := $(shell command -v python3 2> /dev/null)
PLATFORM := $(shell uname)

LOCAL_BIN_DIR := $(HOME)/.local/bin

FISH_PHONY_CONFIG := generated/.fish_config
FISH_CONFIG := fish/config.fish
FISH_CHECK := $(shell fish/checks.sh)
FISH_DIR := $(HOME)/.config/fish
FISH_TARGET := $(FISH_DIR)/config.fish

HELIX_CHECK := $(shell helix/checks.sh)
HELIX_CONFIG_DIR := $(HOME)/.config/helix
HELIX_CONFIG := helix/config.toml
HELIX_LANG := helix/languages.toml
HELIX_LANG_TARGET := $(HELIX_CONFIG_DIR)/languages.toml
HELIX_CONFIG_TARGET := $(HELIX_CONFIG_DIR)/config.toml

TMUX_CHECK := $(shell tmux/checks.sh)
TMUX_PHONY_CONFIG := generated/.tmux_config
TMUX_CONFIG := tmux/tmux.conf
TMUX_TARGET := $(HOME)/.tmux.conf

WEZTERM_CONFIG_DIR := $(HOME)/.config/wezterm
WEZTERM_LOCAL_SCRIPT := local/wezterm.local.lua
WEZTERM_LOCAL_TARGET := $(WEZTERM_CONFIG_DIR)/local_cfg.lua
WEZTERM_TARGET_SCRIPT := wezterm/config.lua
WEZTERM_TARGET := $(WEZTERM_CONFIG_DIR)/wezterm.lua

POSTPROCESS_SCRIPT := scripts/postprocess.sh

clean:
	-@rm $(FISH_TARGET) $(TMUX_TARGET) $(HELIX_LANG_TARGET) $(HELIX_CONFIG_TARGET) $(WEZTERM_LOCAL_TARGET) $(WEZTERM_TARGET)
	$(info Removed common linked targets)

	-@rm -rf generated/
	$(info Deleted generated configurations directory)

generated:
ifndef PYTHON
	$(error "No python3 binaries found in $(PATH); please install Python3 before continuing.")
endif
	@mkdir -p generated/
	$(info Created generated configurations directory)

$(FISH_PHONY_CONFIG): generated
ifneq (1,$(FISH_CHECK))
	$(error Fish environment check failed: cannot find fish binary.)
endif
	$(info Fish environment check successful.)
	@touch $(FISH_PHONY_CONFIG)
	$(info Fish configuration file at $(FISH_CONFIG))

$(TMUX_PHONY_CONFIG): generated
	@touch $(TMUX_PHONY_CONFIG)
	$(info tmux configuration file at $(TMUX_CONFIG))

$(FISH_TARGET): $(FISH_PHONY_CONFIG)
	@mkdir -p $(FISH_DIR)
	@ln -s $(shell pwd)/$(FISH_CONFIG) $(FISH_TARGET)
	$(info Linking $(FISH_TARGET) to $(FISH_CONFIG))

$(TMUX_TARGET): $(TMUX_PHONY_CONFIG)
ifeq (1,${TMUX_CHECK})
	@ln -s $(shell pwd)/$(TMUX_CONFIG) $(TMUX_TARGET)
	$(info Linking $(TMUX_CONFIG) to $(TMUX_TARGET))
endif

$(HELIX_PHONY_CONFIG): generated
ifneq (1,${HELIX_CHECK})
	$(error Helix environment check failed: cannot find helix editor binary)
endif
	$(info Helix environment check successful.)
	@touch $(HELIX_PHONY_CONFIG)
	@mkdir -p $(HELIX_CONFIG_DIR)
	$(info Helic configuration files located in $(HELIX_CONFIG_DIR))
	
$(HELIX_CONFIG_TARGET): $(HELIX_PHONY_CONFIG)
	@ln -s $(shell pwd)/$(HELIX_CONFIG) $(HELIX_CONFIG_TARGET)
	$(info Linking $(HELIX_CONFIG_TARGET) to $(HELIX_CONFIG))
	
$(HELIX_LANG_TARGET): $(HELIX_PHONY_CONFIG)
	@ln -s $(shell pwd)/$(HELIX_LANG) $(HELIX_LANG_TARGET)
	$(info Linking $(HELIX_LANG_TARGET) to $(HELIX_LANG))

$(WEZTERM_CONFIG_DIR):
	@mkdir -p $(WEZTERM_CONFIG_DIR)
	$(info Creating $(WEZTERM_CONFIG_DIR))
	
$(WEZTERM_LOCAL_TARGET): $(WEZTERM_CONFIG_DIR)
ifeq (,$(wildcard $(WEZTERM_LOCAL_SCRIPT)))
	$(info No wezterm localizations found.)
else
	@ln -s $(shell pwd)/$(WEZTERM_LOCAL_SCRIPT) $(WEZTERM_LOCAL_TARGET)
	$(info Linking $(WEZTERM_LOCAL_TARGET) to $(WEZTERM_LOCAL_SCRIPT))
endif

$(WEZTERM_TARGET): $(WEZTERM_CONFIG_DIR)
	@ln -s $(shell pwd)/$(WEZTERM_TARGET_SCRIPT) $(WEZTERM_TARGET)
	$(info Linking $(WEZTERM_TARGET) to $(WEZTERM_TARGET_SCRIPT))


all: core
core: shell wezterm 
shell: fish tmux helix

fish: $(FISH_TARGET)
helix: $(HELIX_CONFIG_TARGET) $(HELIX_LANG_TARGET)
tmux: $(TMUX_TARGET)
wezterm: $(WEZTERM_TARGET) $(WEZTERM_LOCAL_TARGET)

