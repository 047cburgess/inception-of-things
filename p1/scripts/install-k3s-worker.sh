#!/bin/bash
set -eup
COLOR=$'🐶 \033[1;38;5;205m'
RESET=$' \033[0m'

echo "$COLOR Installing k3s agent. . .$RESET"

# Download and install K3S Agent
K3S_URL=https://192.168.56.110:6443 
CONFIG="agent --server $K3S_URL --token $K3S_TOKEN --flannel-iface=eth1"
curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="$CONFIG" sh -s -


# Quality of life
echo "export PS1='🐶 %> '" >> /home/vagrant/.bashrc
echo "alias k=kubectl" >> /home/vagrant/.bashrc
