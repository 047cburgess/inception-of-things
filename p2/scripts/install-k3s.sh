#!/bin/bash
set -eup
COLOR=$'🙉 \033[38;5;219;48;5;198m'
RESET=$' \033[0m'

echo "$COLOR Installing k3s. . .$RESET"

# Download and run the official K3s install script
# This installs K3s as a systemd service and starts it automatically
curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="--write-kubeconfig-mode 644 --flannel-iface=eth1" sh -

systemctl status k3s

# Create the .kube directory if it doesn't exist
mkdir -p ~/.kube

# Copy the K3s kubeconfig to home directory
# This avoids needing sudo for every kubectl command
sudo cp /etc/rancher/k3s/k3s.yaml ~/.kube/config

# Fix ownership so user can read the file
sudo chown $(id -u):$(id -g) ~/.kube/config

# Verify the configuration works
kubectl get nodes
