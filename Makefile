VAGRANT_HOME         := $(HOME)/goinfre/vagrant/home
VAGRANT_DOTFILE_PATH := $(HOME)/goinfre/vagrant/.vagrant

VENV := VAGRANT_HOME=$(VAGRANT_HOME) VAGRANT_DOTFILE_PATH=$(VAGRANT_DOTFILE_PATH)

all up:
	mkdir -p $(VAGRANT_HOME) $(VAGRANT_DOTFILE_PATH)
	VBoxManage setproperty machinefolder $(HOME)/goinfre/vagrant/vms
	$(VENV) vagrant up

ssh:
	$(VENV) vagrant ssh

destroy:
	$(VENV) vagrant destroy -f

fclean clean: destroy
	rm -rf $(VAGRANT_HOME)
	rm -rf $(VAGRANT_DOTFILE_PATH)

re: destroy up

.PHONY: all up ssh fclean clean
