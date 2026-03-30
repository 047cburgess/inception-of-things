VAGRANT_HOME         := $(HOME)/goinfre/vagrant/home
VAGRANT_DOTFILE_PATH := $(HOME)/goinfre/vagrant/.vagrant

VENV := \
	VAGRANT_HOME=$(VAGRANT_HOME) \
	VAGRANT_DOTFILE_PATH=$(VAGRANT_DOTFILE_PATH) \
	VAGRANT_DISABLE_VBOXSYMLINKCREATE=1

VENV += \
	P3_REPO=https://github.com/047cburgess/iot-public-caburges.git

all up:
	mkdir -p $(VAGRANT_HOME) $(VAGRANT_DOTFILE_PATH)
	VBoxManage setproperty machinefolder $(HOME)/goinfre/vagrant/vms
	$(VENV) vagrant up 

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
