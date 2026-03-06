This is just how I managed to run Vagrant with my home dir at 96%. Just putting it here in case we need a similar solution.

The ticket I made that day about it not working in Fedora:
https://meta.intra.42.fr/issues/26810

`Vagrantfile`

```
Vagrant.configure("2") do |config|
  config.vm.box = "generic/debian12"

  config.vm.synced_folder ".", "/vagrant", SharedFoldersEnableSymlinksCreate: false
  
  config.ssh.extra_args = ["-t", "cd /vagrant; bash"]
  
  config.vm.provider "virtualbox" do |vb|
    vb.memory = "1024"
    vb.cpus = 2
  end

  config.vm.provision "shell", inline: <<-SHELL
    export DEBIAN_FRONTEND=noninteractive
    apt-get update
    apt-get install -y curl
  SHELL
end
```

the `Makefile` to launch it in f4 and f6
```
VAGRANT_HOME         := $(HOME)/goinfre/vagrant/home
VAGRANT_DOTFILE_PATH := $(HOME)/goinfre/vagrant/.vagrant

VENV := VAGRANT_HOME=$(VAGRANT_HOME) VAGRANT_DOTFILE_PATH=$(VAGRANT_DOTFILE_PATH)

all up:
	mkdir -p $(VAGRANT_HOME) $(VAGRANT_DOTFILE_PATH)
	VBoxManage setproperty machinefolder $(HOME)/goinfre/vagrant/vms
	$(VENV) vagrant up
	@echo
	@echo "💡 Recommended workflow:"
	@echo "       make dev"
	@echo "       make fclean"
	@echo

dev: up
	code .
	$(VENV) vagrant ssh

fclean clean:
	$(VENV) vagrant destroy -f
	rm -rf $(VAGRANT_DOTFILE_PATH)

re: fclean all

.PHONY: all up dev re fclean clean
```
