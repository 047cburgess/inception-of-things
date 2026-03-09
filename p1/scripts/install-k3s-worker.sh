#!/bin/bash
# Download and run the official K3s install script

TOKEN=$(cat /home/vagrant/shared/token_p1)

curl -sfL https://get.k3s.io | K3S_URL=https://192.168.56.110:6443 K3S_TOKEN=$TOKEN sh -

systemctl status k3s
