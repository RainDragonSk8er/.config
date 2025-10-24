help:
	@echo "Valid targets:"
	@echo "common   - Common dotfiles and dependencies"
	@echo "dotfiles - Only copy dotfiles"
	@echo "home     - Install home group packages"
	@echo "server   - Install server group packages"

UNAME_S := $(shell uname -s)
ifeq ($(UNAME_S),Linux)
currOs := linux
currDist := $(shell cat /etc/os-release | sed -n 's/^ID=\(.*\)$$/\1/p')
endif

host := $(hostnamectl hostname)

$(info -- Running on host $(host))
$(info -- Detected OS $(currOs))
$(info -- Detected distribution $(currDist))
DEPENDENCY_TARGETS =
DOTFILE_TARGETS =
SOFTWARE_TARGETS =
CLEANUP_TARGETS =

# Group vars
HOME_TARGETS =
SERVER_TARGETS =

# First, check the OS
ifeq ($(currOs),linux)
$(info -- Linux identified)

ifeq ($(currDist),arch)
$(info -- Loading arch-specific stuff)
-include make/distros/arch.mk
endif # mint

ifeq ($(currDist),ubuntu)
$(info -- Loading ubuntu-specific stuff)
-include make/distros/ubuntu.mk
endif # ubuntu

endif # linux

# Host-specific include
-include make/host/$(host).mk

$(info $(DOTFILE_TARGETS))

common-dotfiles:
	@echo "Install some common dotfiles"

dependencies: $(DEPENDENCY_TARGETS);
dotfiles: common-dotfiles $(DOTFILE_TARGETS);
software: $(SOFTWARE_TARGETS);
cleanup: $(CLEANUP_TARGETS);

# Common setup process
core: dependencies dotfiles software
common: core cleanup

home: core $(HOME_TARGETS) cleanup
server: core $(SERVER_TARGETS) cleanup

