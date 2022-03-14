PYTHON := $(shell command -v python3 2> /dev/null)
PLATFORM := $(shell uname)

ALACRITTY_COMMON := alacritty/conf.d/common.yml alacritty/themes/powershell.yml
ALACRITTY_CONFIG := generated/alacritty.yml
ALACRITTY_TARGET := $(HOME)/.config/alacritty.yml

FISH_PHONY_CONFIG := generated/.fish_config
FISH_CONFIG := fish/config.fish
FISH_CHECK := $(shell fish/checks.sh)
FISH_DIR := $(HOME)/.config/fish
FISH_TARGET := $(FISH_DIR)/config.fish

I3_COMMON := i3/conf.d/common i3/conf.d/floating_exceptions i3/conf.d/applications \
             i3/conf.d/autostart i3/themes/default
I3_CONFIG := generated/i3.config
I3_DIR := $(HOME)/.config/i3
I3_TARGET := $(I3_DIR)/config

PICOM_PHONY_CONFIG := generated/.picom_config
PICOM_CONFIG := picom/picom.conf
PICOM_TARGET := $(HOME)/.config/picom.conf

REDSHIFT_PHONY_CONFIG := generated/.redshift_config
REDSHIFT_CONFIG := redshift/redshift.conf
REDSHIFT_DIR := $(HOME)/.config/redshift
REDSHIFT_TARGET := $(REDSHIFT_DIR)/redshift.conf

all: $(ALACRITTY_CONFIG) $(FISH_PHONY_CONFIG) $(I3_CONFIG) $(PICOM_PHONY_CONFIG) $(REDSHIFT_PHONY_CONFIG)

clean:
	-@rm $(ALACRITTY_TARGET) $(FISH_TARGET)
	$(info Removed common linked targets)

ifeq (Linux, $(PLATFORM))
	-@rm $(I3_TARGET) $(PICOM_TARGET) $(REDSHIFT_TARGET)
	$(info Removed Linux-specific linked targets)
endif

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
	$(info Generated alacritty configuration file at $(ALACRITTY_CONFIG))

$(FISH_PHONY_CONFIG): generated
ifneq (1,$(FISH_CHECK))
	$(error Fish environment check failed: cannot find fish binary.)
endif
	$(info Fish environment check successful.)
	@touch $(FISH_PHONY_CONFIG)
	$(info Fish configuration file at $(FISH_CONFIG))

$(I3_CONFIG): generated
ifeq (Linux, $(PLATFORM))
	@printf "# WARNING: autogenerated configuration file\n\n" > $(I3_CONFIG) && \
		cat $(I3_COMMON) >> $(I3_CONFIG)
	$(info Generated i3 configuration file at $(I3_CONFIG))
endif

$(PICOM_PHONY_CONFIG): generated
ifeq (Linux, $(PLATFORM))
	@touch $(PICOM_PHONY_CONFIG)
	$(info Picom configuration file at $(FISH_CONFIG))
endif

$(REDSHIFT_PHONY_CONFIG): generated
ifeq (Linux, $(PLATFORM))
	@touch $(REDSHIFT_PHONY_CONFIG)
	$(info Redshift configuration file at $(REDSHIFT_CONFIG))
endif

$(ALACRITTY_TARGET): $(ALACRITTY_CONFIG) $(FISH_TARGET)
	@ln -s $(shell pwd)/$(ALACRITTY_CONFIG) $(ALACRITTY_TARGET)
	$(info Linking $(ALACRITTY_TARGET) to $(ALACRITTY_CONFIG))

$(FISH_TARGET): $(FISH_PHONY_CONFIG)
	@mkdir -p $(FISH_DIR)
	@ln -s $(shell pwd)/$(FISH_CONFIG) $(FISH_TARGET)
	$(info Linking $(FISH_TARGET) to $(FISH_CONFIG))

$(I3_TARGET): $(I3_CONFIG) $(PICOM_PHONY_CONFIG)
ifeq (Linux, $(PLATFORM))
	@mkdir -p $(I3_DIR)
	@ln -s $(shell pwd)/$(I3_CONFIG) $(I3_TARGET)
	$(info Linking $(I3_CONFIG) to $(I3_TARGET))
endif

$(PICOM_TARGET): $(PICOM_PHONY_CONFIG)
ifeq (Linux, $(PLATFORM))
	@./picom/checks.sh
	@ln -s $(shell pwd)/$(PICOM_CONFIG) $(PICOM_TARGET)
	$(info Linking $(PICOM_CONFIG) to $(PICOM_TARGET))
endif

$(REDSHIFT_TARGET): $(REDSHIFT_PHONY_CONFIG)
ifeq (Linux, $(PLATFORM))
	@./redshift/install.sh "$(REDSHIFT_CONFIG)" "$(REDSHIFT_TARGET)" "$(REDSHIFT_DIR)"
endif

install: $(ALACRITTY_TARGET) $(FISH_TARGET) $(I3_TARGET) $(PICOM_TARGET) $(REDSHIFT_TARGET)