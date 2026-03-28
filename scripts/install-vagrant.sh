#!/bin/bash
set -eup
export DEBIAN_FRONTEND=noninteractive
COLOR=$'🚧 \033[1;38;5;205m'
RESET=$' \033[0m'

if which vagrant > /dev/null 2>&1; then
  exit
fi

# Virtualbox
echo "$COLOR Installing Virtualbox...$RESET"
apt-get install -y -qq lsb-release

echo "deb http://deb.debian.org/debian $(lsb_release -cs)-backports main contrib" \
  > /etc/apt/sources.list.d/backports.list

apt-get install -y -qq fasttrack-archive-keyring

echo "deb http://fasttrack.debian.net/debian-fasttrack/ $(lsb_release -cs)-fasttrack main contrib" \
  > /etc/apt/sources.list.d/fasttrack.list
echo "deb http://fasttrack.debian.net/debian-fasttrack/ $(lsb_release -cs)-backports-staging main contrib" \
  >> /etc/apt/sources.list.d/fasttrack.list

apt-get update -qq
apt-get install -y -qq dkms linux-headers-$(uname -r) linux-headers-amd64
apt-get install -y -qq virtualbox

# Vagrant
echo "$COLOR Installing Vagrant...$RESET"
wget -qO - https://apt.releases.hashicorp.com/gpg | gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(grep -oP '(?<=UBUNTU_CODENAME=).*' /etc/os-release || lsb_release -cs) main" \
  > /etc/apt/sources.list.d/hashicorp.list

apt-get update -qq
apt-get install -y -qq vagrant

echo 'VAGRANT_HOME=/home/vagrant/.vagrant.d' >> /etc/environment
echo 'VAGRANT_DOTFILE_PATH=/home/vagrant/.vagrant' >> /etc/environment
