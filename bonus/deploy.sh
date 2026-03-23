#!/bin/bash 

# Need to add proper error handling and condition checks

# Make sure the cluster is up
k3d cluster start p3 || (k3d cluster delete p3 && bash ~/p3/deploy.sh)

echo Setting up port forwarding . . .
k3d cluster edit p3 --port-add 8081:32080@loadbalancer || k3d cluster start p3

kubectl create namespace gitlab

echo Waiting for Argo CD server to be ready. . .
kubectl rollout status deployment argocd-server -n argocd --timeout=300s


echo 'Applying Helm gitlab script up.sh'
bash ~/bonus/up.sh

echo "Not impelmented"
exit 0
#TODO: create the gitlab repository 
#TODO: push the confs/dev.yaml into it
#TODO: connect the repo to argocd


echo Updating will  . . .
kubectl apply -f ~/bonus/confs/app.yaml


# View the status of the application
argocd app get will
