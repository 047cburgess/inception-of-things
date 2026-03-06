VAGRANT_HOME         := $(HOME)/goinfre/vagrant/home
VAGRANT_DOTFILE_PATH := $(HOME)/goinfre/vagrant/.vagrant

VENV := VAGRANT_HOME=$(VAGRANT_HOME) VAGRANT_DOTFILE_PATH=$(VAGRANT_DOTFILE_PATH)

all up:
	mkdir -p $(VAGRANT_HOME) $(VAGRANT_DOTFILE_PATH)
	VBoxManage setproperty machinefolder $(HOME)/goinfre/vagrant/vms
	$(VENV) vagrant up

ssh:
	$(VENV) vagrant ssh

fclean clean:
	$(VENV) vagrant destroy -f
	rm -rf $(VAGRANT_DOTFILE_PATH)

re: fclean all

.PHONY: all up dev re fclean clean
