#!/bin/bash
set -eup

# Download and run the official K3s install script
# This installs K3s as a systemd service and starts it automatically
curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="--write-kubeconfig-mode 644 --flannel-iface=eth1" sh -

systemctl status k3s

mkdir -p ~/.kube

# Copy the K3s kubeconfig to home directory
# This avoids needing sudo for every kubectl command
sudo cp /etc/rancher/k3s/k3s.yaml ~/.kube/config

# Fix ownership so user can read the file
sudo chown $(id -u):$(id -g) ~/.kube/config

# Verify the configuration works
kubectl get nodes

# Copying the auto-generated token to the shared folder so the agent can access it
cp /var/lib/rancher/k3s/server/token /token/agent-token
