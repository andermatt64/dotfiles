PYTHON := $(shell command -v python3 2> /dev/null)
PLATFORM := $(shell uname)

LOCAL_BIN_DIR := $(HOME)/.local/bin

ALACRITTY_COMMON := alacritty/conf.d/common.yml alacritty/themes/powershell.yml
ALACRITTY_CONFIG := generated/alacritty.yml
ALACRITTY_TARGET := $(HOME)/.config/alacritty.yml

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

LVIM_CHECK := $(shell lunarvim/lvim_check.sh)
LVIM_GUI_CHECK := $(shell lunarvim/neovide_check.sh)

LVIM_PHONY_CONFIG := generated/.lvim_config
LVIM_CONFIG := lunarvim/config.lua
LVIM_CONFIG_TARGET := $(HOME)/.config/lvim/config.lua

LVIM_PHONY_GUI_BIN := generated/.lvim_gui_bin
LVIM_GUI_BIN := lunarvim/lvim-gui
LVIM_GUI_BIN_TARGET := $(LOCAL_BIN_DIR)/lvim-gui

TMUX_CHECK := $(shell tmux/checks.sh)
TMUX_PHONY_CONFIG := generated/.tmux_config
TMUX_CONFIG := tmux/tmux.conf
TMUX_TARGET := $(HOME)/.tmux.conf

POSTPROCESS_SCRIPT := scripts/postprocess.sh

clean:
	-@rm $(ALACRITTY_TARGET) $(FISH_TARGET) $(LVIM_CONFIG_TARGET) $(LVIM_GUI_BIN_TARGET) $(TMUX_TARGET) $(HELIX_LANG_TARGET) $(HELIX_CONFIG_TARGET)
	$(info Removed common linked targets)

	-@rm -rf generated/
	$(info Deleted generated configurations directory)

generated:
ifndef PYTHON
	$(error "No python3 binaries found in $(PATH); please install Python3 before continuing.")
endif
	@mkdir -p generated/
	$(info Created generated configurations directory)

$(ALACRITTY_CONFIG): generated
ifeq (Darwin, $(PLATFORM))
	@printf "# WARNING: autogenerated configuration file\n\n" > $(ALACRITTY_CONFIG) && \
		cat alacritty/platform/macos.yml $(ALACRITTY_COMMON) >> $(ALACRITTY_CONFIG)
else ifeq (Linux, $(PLATFORM))
	@printf "# WARNING: autogenerated configuration file\n\n" > $(ALACRITTY_CONFIG) && \
		cat alacritty/platform/linux.yml $(ALACRITTY_COMMON) >> $(ALACRITTY_CONFIG)
else
	$(error $(PLATFORM) is currently not supported, sorry.)
endif
	@sh $(POSTPROCESS_SCRIPT) "alacritty" "$(ALACRITTY_CONFIG)"
	$(info Generated alacritty configuration file at $(ALACRITTY_CONFIG))

$(FISH_PHONY_CONFIG): generated
ifneq (1,$(FISH_CHECK))
	$(error Fish environment check failed: cannot find fish binary.)
endif
	$(info Fish environment check successful.)
	@touch $(FISH_PHONY_CONFIG)
	$(info Fish configuration file at $(FISH_CONFIG))

$(LVIM_PHONY_CONFIG): generated
ifneq (1,${LVIM_CHECK})
	$(error LunarVim environment check failed: LunarVim not installed)
endif
	$(info LunarVim environment check successful.)
	@touch $(LVIM_PHONY_CONFIG)
	$(info LunarVim configuration file at $(LVIM_CONFIG))

$(LVIM_PHONY_GUI_BIN): generated
ifeq (1,${LVIM_GUI_CHECK})
	@touch $(LVIM_PHONY_GUI_BIN)
	$(info LunarVim neovide script at $(LVIM_GUI_BIN))
endif

$(TMUX_PHONY_CONFIG): generated
	@touch $(TMUX_PHONY_CONFIG)
	$(info tmux configuration file at $(TMUX_CONFIG))

$(ALACRITTY_TARGET): $(ALACRITTY_CONFIG) $(FISH_TARGET)
	@ln -s $(shell pwd)/$(ALACRITTY_CONFIG) $(ALACRITTY_TARGET)
	$(info Linking $(ALACRITTY_TARGET) to $(ALACRITTY_CONFIG))

$(FISH_TARGET): $(FISH_PHONY_CONFIG)
	@mkdir -p $(FISH_DIR)
	@ln -s $(shell pwd)/$(FISH_CONFIG) $(FISH_TARGET)
	$(info Linking $(FISH_TARGET) to $(FISH_CONFIG))

$(LVIM_CONFIG_TARGET): $(LVIM_PHONY_CONFIG)
	@ln -s $(shell pwd)/$(LVIM_CONFIG) $(LVIM_CONFIG_TARGET)
	$(info Linking $(LVIM_CONFIG_TARGET) to $(LVIM_CONFIG))

$(LVIM_GUI_BIN_TARGET): $(LVIM_PHONY_GUI_BIN)
ifeq (1,${LVIM_GUI_CHECK})
	@mkdir -p $(LOCAL_BIN_DIR)
	@ln -s $(shell pwd)/$(LVIM_GUI_BIN) $(LVIM_GUI_BIN_TARGET)
	$(info Linking $(LVIM_GUI_BIN_TARGET) to $(LVIM_GUI_BIN))
endif

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
		
all: core lvim lvim_gui
core: shell alacritty
shell: fish tmux helix

alacritty: $(ALACRITTY_TARGET)
fish: $(FISH_TARGET)
helix: $(HELIX_CONFIG_TARGET) $(HELIX_LANG_TARGET)
lvim: $(LVIM_CONFIG_TARGET)
lvim_gui: $(LVIM_GUI_BIN_TARGET)
tmux: $(TMUX_TARGET)

