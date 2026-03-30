VAGRANT_HOME         := $(HOME)/goinfre/vagrant/home
VAGRANT_DOTFILE_PATH := $(HOME)/goinfre/vagrant/.vagrant

VENV := \
	VAGRANT_HOME=$(VAGRANT_HOME) \
	VAGRANT_DOTFILE_PATH=$(VAGRANT_DOTFILE_PATH) \
	VAGRANT_DISABLE_VBOXSYMLINKCREATE=1

-include .env

all up:
	@if [ -z "$(P3_REPO)" ]; then \
		echo "Error: P3_REPO is not set. Create a .env file with P3_REPO=<url>"; \
		exit 1; \
	fi
	mkdir -p $(VAGRANT_HOME) $(VAGRANT_DOTFILE_PATH)
	VBoxManage setproperty machinefolder $(HOME)/goinfre/vagrant/vms
	$(VENV) P3_REPO=$(P3_REPO) vagrant up 

ssh:
	$(VENV) vagrant ssh

destroy clean:
	$(VENV) vagrant destroy -f

provision:
	$(VENV) vagrant provision

reload:
	$(VENV) vagrant reload --provision

stop halt:
	$(VENV) vagrant halt

fclean: clean
	rm -rf $(VAGRANT_HOME)
	rm -rf $(VAGRANT_DOTFILE_PATH)

re: destroy up

.PHONY: all up ssh fclean clean stop provision destroy reload re
