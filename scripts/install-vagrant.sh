#!/bin/bash

# Virtualbox
# source: https://wiki.debian.org/VirtualBox#Debian_10_.22Buster.22.2C_Debian_11_.22Bullseye.22.2C_and_Debian_12_.22Bookworm.22-1
apt install lsb-release
echo "deb http://deb.debian.org/debian $(lsb_release -cs)-backports main contrib" | tee /etc/apt/sources.list.d/backports.list
apt install fasttrack-archive-keyring
echo "deb http://fasttrack.debian.net/debian-fasttrack/ $(lsb_release -cs)-fasttrack main contrib" | tee /etc/apt/sources.list.d/fasttrack.list 
echo "deb http://fasttrack.debian.net/debian-fasttrack/ $(lsb_release -cs)-backports-staging main contrib" | tee -a /etc/apt/sources.list.d/fasttrack.list
apt update
apt-get install -y dkms linux-headers-$(uname -r) linux-headers-amd64
apt install virtualbox -y

# Vagrant
wget -O - https://apt.releases.hashicorp.com/gpg | gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(grep -oP '(?<=UBUNTU_CODENAME=).*' /etc/os-release || lsb_release -cs) main" | tee /etc/apt/sources.list.d/hashicorp.list
apt-get update
apt-get install vagrant -y

# set env var so box cache is stored in vagrant home
echo 'VAGRANT_HOME=/home/vagrant/.vagrant.d' >> /etc/environment