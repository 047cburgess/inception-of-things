#!/bin/bash
# Download and run the official K3s install script

tok=$(cat /hellokittytoken/agent-token)
echo $tok "TOKENNNNN"
curl -sfL https://get.k3s.io | K3S_URL=https://192.168.56.110:6443 K3S_TOKEN=$tok INSTALL_K3S_EXEC="--flannel-iface=eth1" sh -

# #systemctl status k3s
