#!/bin/bash 
k3d cluster create p3 \
  -p "8888:30000@loadbalancer"

kubectl create namespace argocd

kubectl apply -n argocd --server-side --force-conflicts \
  -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

echo "Waiting for Argo CD server . . ."
kubectl wait --for=condition=Ready pods --all -n argocd --timeout=300s

# Redirection that works only after argocd is up - in the background 
# There must be a cleaner way to do this -> use k3d ingress or node port
kubectl port-forward svc/argocd-server -n argocd 8080:443 --address 0.0.0.0 &


#kubectl patch svc argocd-server -n argocd \
#  -p '{"spec": {"type": "NodePort", "ports": [{"port": 443, "nodePort": 30000, "protocol": "TCP"}]}}'
echo "Ready! Available at https://localhost:8080"

echo "Try curl https://localhost:8080 --insecure"
# kubectl apply -f confs
# TODO: add wait for it to be ready before applying confs

#Get password: need to still adjust manually as other text in there
#PASSWORD= $(argocd admin initial-password -n argocd)

#Log in
#argocd login localhost:8080 --username admin --password ${PASSWORD} --insecure

#Change the password
#argocd account update-password --current-password ${PASSWORD} --new-password <newpassword>

#
# Log out
# argocd logout localhost:8080
#
# Log back in
# argocd login localhost:8080 --username admin --password <pass> --insecure
#
# Delete the initial passwd secret
# kubectl -n argocd delete secret argocd-initial-admin-secret
#
# Create the app via CLI
# kubectl config set-context --current --namespace=argocd
# argocd app create will --repo https://github.com/047cburgess/iot-public.git --path will --dest-server https://kubernetes.default.svc --dest-namespace dev
#
# View the status of the application
# argocd app get will
#
# Deploy (sync) the app
# argocd app sync will
