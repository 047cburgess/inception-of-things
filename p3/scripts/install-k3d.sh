#!/bin/bash
set -euo pipefail

# Install kubectl
if ! which kubectl ; then
  echo 'Installing k3d. . .'
  curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
  install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
fi
rm -f kubectl

# Install k3d
if ! which k3d ; then
  curl -s https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash
fi

# Install Argo CD
if ! which argocd ; then
  curl -sSL -o argocd-linux-amd64 \
    https://github.com/argoproj/argo-cd/releases/latest/download/argocd-linux-amd64
  install -m 555 argocd-linux-amd64 /usr/local/bin/argocd
fi
rm -f argocd-linux-amd64


