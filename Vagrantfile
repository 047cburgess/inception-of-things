# -*- mode: ruby -*-
# vi: set ft=ruby :

ENV["VAGRANT_DISABLE_VBOXSYMLINKCREATE"] = "1"

Vagrant.configure("2") do |config|
  config.vm.box = "generic/debian12"
  config.vm.hostname = "expozoo"

  config.vm.provider "virtualbox" do |v|
    v.name = "expozoo"
    v.memory = 1024 * 8
    v.cpus = 4
    # Activate nested virtualization to run VMs inside the VM
    v.customize ["modifyvm", :id, "--nested-hw-virt", "on"]
  end

  # Install Vagrant and Virtualbox
  config.vm.provision "shell", path: "scripts/install-vagrant.sh"

  # Mount project at ~/iot for convenience (read only)
  config.vm.synced_folder "./", "/home/vagrant/iot", mount_options: ["ro"], type: "rsync", rsync__exclude: ".git/"

  # Mount Vagrant cache folder so that vagrant does not re-download boxes every time
  config.vm.synced_folder ENV['VAGRANT_HOME'], "/home/vagrant/.vagrant.d", type: "rsync"

  # Install Docker and k3d
  config.vm.provision "shell", path: "scripts/install-docker.sh"
  config.vm.provision "shell", path: "scripts/install-k3d.sh"

  # Have an unique prompt when connected to this vm
  config.vm.provision "shell", path: "scripts/emoji-prompt.sh"


end
