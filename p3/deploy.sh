#!/bin/bash 
k3d cluster create p3 \
  -p "8888:30000@loadbalancer"

kubectl create namespace argocd

kubectl apply -n argocd --server-side --force-conflicts \
  -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

echo "Waiting for Argo CD server . . ."
kubectl wait --for=condition=Ready pods --all -n argocd --timeout=10s

# Redirection that works only after argocd is up
kubectl port-forward svc/argocd-server -n argocd 8080:443 &

echo "Ready! Available at https://localhost:8080"
echo "Try curl https://localhost:8080 --insecure"
# kubectl apply -f confs
# TODO: add wait for it to be ready before applying confs
