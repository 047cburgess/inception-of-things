# -*- mode: ruby -*-
# vi: set ft=ruby :

ENV["VAGRANT_DISABLE_VBOXSYMLINKCREATE"] = "1"

Vagrant.configure("2") do |config|
  config.vm.box = "generic/debian12"
  config.vm.hostname = "expozoo"
  config.vm.network :forwarded_port, guest: 8888, host: 8888
  config.vm.network :forwarded_port, guest: 8080, host: 8080
  config.vm.network :forwarded_port, guest: 8081, host: 8081
  config.vm.network :forwarded_port, guest: 8443, host: 8443

  config.vm.provider "virtualbox" do |v|
    v.name = "expozoo"
    v.memory = 1024 * 10
    v.cpus = 4
    # Activate nested virtualization to run VMs inside the VM
    v.customize ["modifyvm", :id, "--nested-hw-virt", "on"]
  end


  # Mount project folders for live sync
  config.vm.synced_folder "./p1", "/home/vagrant/p1"
  config.vm.synced_folder "./p2", "/home/vagrant/p2"
  config.vm.synced_folder "./p3", "/home/vagrant/p3"
  config.vm.synced_folder "./bonus", "/home/vagrant/bonus"

  # Mount Vagrant cache folder so that vagrant does not re-download boxes every time
  config.vm.synced_folder ENV['VAGRANT_HOME'], "/home/vagrant/.vagrant.d"
  #
  # Install Vagrant and Virtualbox
  config.vm.provision "shell", path: "scripts/install-vagrant.sh"

  # Colors
  config.vm.provision "shell", path: "scripts/colors.sh", args: ["-export"]
  
  # Have an unique prompt when connected to this vm
  config.vm.provision "shell", path: "scripts/quality-of-life.sh"

end
