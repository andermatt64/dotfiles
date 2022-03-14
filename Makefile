PYTHON := $(shell command -v python3 2> /dev/null)
PLATFORM := $(shell uname)

all: generated/alacritty.yml

clean:
	@rm -rf generated/
	$(info Deleted generated configurations directory)

generated:
ifndef PYTHON
	$(error "No python3 binaries found in $(PATH); please install Python3 before continuing")
endif
	mkdir -p generated
	$(info Created generated configurations directory)

generated/alacritty.yml: generated
ifeq (Darwin, $(PLATFORM))
	$(info On MacOS)
else ifeq (Linux, $(PLATFORM))
	$(info On Linux)
else
	$(error Unsupported platform)
endif

install: