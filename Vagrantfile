# -*- mode: ruby -*-
# vi: set ft=ruby :

# Do not create symlinks inside shared folders
VAGRANT_DISABLE_VBOXSYMLINKCREATE=1

# Tell scripts they don't have a tty
ENV["DEBIAN_FRONTEND"] = "noninteractive"

Vagrant.configure("2") do |config|
  config.vm.box = "generic/debian12"
  config.vm.hostname = "whatever"

  config.vm.provider "virtualbox" do |v|
    v.memory = 1024 * 10
    v.cpus = 4
    # Activate nested virtualization to run VMs inside the VM
    v.customize ["modifyvm", :id, "--nested-hw-virt", "on", "--name", "whatever"]
  end

  # Install Vagrant and Virtualbox
  config.vm.provision "shell", path: "scripts/install-vagrant.sh"

  # Mount project at ~/iot for convenience (read only)
  config.vm.synced_folder "./", "/home/vagrant/iot", mount_options: ["ro"]

  # Mount Vagrant cache folder so that vagrant does not re-download boxes every time
  config.vm.synced_folder ENV['VAGRANT_HOME'], "/home/vagrant/.vagrant.d"

  # Prepare shared folder
  # config.vm.provision "shell", inline: "mkdir /home/vagrant/shared"
  # config.vm.provision "shell", inline: "chown vagrant /home/vagrant/shared"

end
