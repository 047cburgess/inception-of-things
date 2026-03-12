#!/bin/bash

k3d cluster create p3 -p "8888:80@loadbalancer"
kubectl apply -f confs