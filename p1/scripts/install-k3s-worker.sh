#!/bin/bash
set -eup

# Make sure the agent-token exists before ending
echo Waiting for agent-token . . .
while [ ! -f "/token/agent-token" ]
do
  sleep 0.2
done
echo agent-token exists!
TOKEN=$(cat /token/agent-token)

# Download and install K3S Agent
K3S_URL=https://192.168.56.110:6443 
CONFIG="agent --server $K3S_URL --token $TOKEN --flannel-iface=eth1"
curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="$CONFIG" sh -s -


