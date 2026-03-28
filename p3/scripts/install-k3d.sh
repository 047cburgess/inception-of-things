#!/bin/bash
set -euo pipefail
COLOR=$'🐋 \033[38;5;219;48;5;198m'
RESET=$' \033[0m'

# Install kubectl
if ! which kubectl ; then
  echo "$COLOR Installing kubectl. . .$RESET"
  curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
  install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
fi
rm -f kubectl

# Install k3d
if ! which k3d ; then
  echo "$COLOR Installing k3d. . .$RESET"
  curl -s https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash
fi

# Install Argo CD
if ! which argocd ; then
  echo "$COLOR Installing Argo CD. . .$RESET"
  curl -sSL -o argocd-linux-amd64 \
    https://github.com/argoproj/argo-cd/releases/latest/download/argocd-linux-amd64
  install -m 555 argocd-linux-amd64 /usr/local/bin/argocd
fi
rm -f argocd-linux-amd64


