# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANT_DISABLE_VBOXSYMLINKCREATE=1

Vagrant.configure("2") do |config|
  config.vm.box = "generic/debian12"
  config.vm.provider "virtualbox" do |v|
    v.memory = 4096
    v.cpus = 4
    v.customize ["modifyvm", :id, "--nested-hw-virt", "on"]
  end

  config.vm.provision "shell", inline: "apt-get update"
  #config.vm.provision "shell", path: "scripts/install-docker.sh"
  #config.vm.provision "shell", path: "scripts/guest-additions.sh"
  config.vm.provision "shell", path: "scripts/install-vagrant.sh"

  config.vm.synced_folder "./", "/home/vagrant/iot", mount_options: ["ro"]
  config.vm.synced_folder ENV['VAGRANT_DOTFILE_PATH'], "/home/vagrant/.vagrant"
end
