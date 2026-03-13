#!/bin/bash 
k3d cluster create p3 -p "8888:30000@loadbalancer"

#
kubectl apply -f confs
# TODO: add wait for it to be ready before applying confs
