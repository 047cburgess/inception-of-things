#!/bin/bash 

# Need to add proper error handling and condition checks
set -euo pipefail

k3d cluster delete bonus 2>/dev/null || true
k3d cluster delete p3 2>/dev/null || true
# TODO see if we can make scripts more robust
# TODO add a clean/destroy/down script to all parts

echo Creating bonus cluster . . .
echo Setting up port forwarding . . .
k3d cluster create bonus \
  -p "8888:30000@loadbalancer" \
  -p "8080:30001@loadbalancer" \
  -p "8081:32080@loadbalancer" \
  -p "8443:32443@loadbalancer"

echo Creating argocd and dev namespaces . . .
kubectl create namespace argocd
kubectl create namespace dev
kubectl create namespace gitlab

echo Downloading and applying argocd yaml from official docs . . .
kubectl apply -n argocd --server-side --force-conflicts \
  -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

echo Waiting for Argo CD server to be ready. . .
#kubectl wait --for=condition=Ready pods --all -n argocd --t
kubectl rollout status deployment argocd-server -n argocd --timeout=300s

echo Creating port forwarding for argocd-server 8080-443 . . .
kubectl patch svc argocd-server -n argocd \
  -p '{"spec":{"type":"NodePort","ports":[{"port":80,"targetPort":8080,"nodePort":30001}]}}'
echo "Ready! Available at https://localhost:8080"

echo Waiting for ArgoCD API . . .
until curl -k https://localhost:8080 >/dev/null 2>&1; do
  sleep 3
done

echo Extracting initial argocd password . . .
ARGOCD_ADMIN_PASSWORD=$(kubectl -n argocd get secret argocd-initial-admin-secret \
  -o jsonpath="{.data.password}" | base64 -d)

echo
echo "ARGOCD admin password: ${ARGOCD_ADMIN_PASSWORD}"
echo $ARGOCD_ADMIN_PASSWORD > 'argocd_pass.txt'

echo Logging in to argocd . . .

argocd login localhost:8080 \
  --username admin \
  --password "${ARGOCD_ADMIN_PASSWORD}" \
  --insecure \
  --grpc-web

echo Deleting the argocd password file . . .
kubectl -n argocd delete secret argocd-initial-admin-secret


#TODO: create the gitlab repository 
#TODO: push the confs/dev.yaml into it
#TODO: connect the repo to argocd


echo Applying the app.yaml config . . .
kubectl apply -f ./confs/app.yaml


# View the status of the application
argocd app get will
