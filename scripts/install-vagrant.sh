#!/bin/bash
set -eup
export DEBIAN_FRONTEND=noninteractive

# Virtualbox
# source: https://wiki.debian.org/VirtualBox#Debian_10_.22Buster.22.2C_Debian_11_.22Bullseye.22.2C_and_Debian_12_.22Bookworm.22-1
apt-get install -y lsb-release
echo "deb http://deb.debian.org/debian $(lsb_release -cs)-backports main contrib" | tee /etc/apt/sources.list.d/backports.list
apt-get install -y fasttrack-archive-keyring
echo "deb http://fasttrack.debian.net/debian-fasttrack/ $(lsb_release -cs)-fasttrack main contrib" | tee /etc/apt/sources.list.d/fasttrack.list 
echo "deb http://fasttrack.debian.net/debian-fasttrack/ $(lsb_release -cs)-backports-staging main contrib" | tee -a /etc/apt/sources.list.d/fasttrack.list
apt-get update
apt-get install -y dkms linux-headers-$(uname -r) linux-headers-amd64
apt-get install -y virtualbox

# Vagrant
wget -qO - https://apt.releases.hashicorp.com/gpg | gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(grep -oP '(?<=UBUNTU_CODENAME=).*' /etc/os-release || lsb_release -cs) main" | tee /etc/apt/sources.list.d/hashicorp.list
apt-get update
apt-get install -y vagrant

# set env var so box cache is stored in vagrant home
echo 'VAGRANT_HOME=/home/vagrant/.vagrant.d' >> /etc/environment

# make sure.vagrant files not created in current folder as we don't have permissions
echo 'VAGRANT_DOTFILE_PATH=/home/vagrant/.vagrant' >> /etc/environment
echo 'K3S_TOKEN=my-token' >> /etc/environment

