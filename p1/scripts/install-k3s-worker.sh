#!/bin/bash
set -eup

# Make sure the agent-token exists before ending
echo Waiting for agent-token . . .
while [ ! -f "/hellokittytoken/agent-token" ]
do
  sleep 0.2
done

echo agent-token exists!
tok=$(cat /hellokittytoken/agent-token)
echo  "got tha token: " $tok "TOKENNNNN"



# Download and install K3S Agent
curl -sfL https://get.k3s.io | K3S_URL=https://192.168.56.110:6443 K3S_TOKEN=$tok INSTALL_K3S_EXEC="--flannel-iface=eth1" sh -
