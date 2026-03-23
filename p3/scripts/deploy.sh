#!/bin/bash 

# Need to add proper error handling and condition checks
set -euo pipefail

k3d cluster delete p3 2>/dev/null || true

echo Creating p3 cluster . . .
echo Setting up p8888 forwarding for wil app . . .
k3d cluster create p3 \
  -p "8888:30000@loadbalancer" \
  -p "8080:30001@loadbalancer" \
  -p "8081:32080@loadbalancer"

echo Creating argocd and dev namespaces . . .
kubectl create namespace argocd
kubectl create namespace dev

echo Downloading and applying argocd yaml from official docs . . .
kubectl apply -n argocd --server-side --force-conflicts \
  -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

echo Waiting for Argo CD server to be ready. . .
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
ARGOCD_ADMIN_USER=admin

echo
echo "ARGOCD admin password: ${ARGOCD_ADMIN_PASSWORD}"
echo Available in ~/p3/argocd_ad_pass.txt
echo $ARGOCD_ADMIN_PASSWORD > ~/p3/argocd_ad_pass.txt

echo Logging in to argocd . . .

argocd login localhost:8080 \
  --username $ARGOCD_ADMIN_USER \
  --password "${ARGOCD_ADMIN_PASSWORD}" \
  --insecure \
  --grpc-web

echo Deleting the argocd password kubectl secret. . .
kubectl -n argocd delete secret argocd-initial-admin-secret

echo Applying the app.yaml config . . .
kubectl apply -f ~/p3/confs/app.yaml


argocd app wait will --health --sync --timeout 300

# View the status of the application
echo 
echo "--------------------------------------------------------"
echo "Argocd User: $ARGOCD_ADMIN_USER"
echo "Argocd Pass: $ARGOCD_ADMIN_PASSWORD"
echo "Access at: https://localhost:8080"

# ARCHIVE COMMANDS
#Change the password
#argocd account update-password --current-password ${PASSWORD} --new-password <newpassword>
#Get password: need to still adjust manually as other text in there
#PASSWORD= $(argocd admin initial-password -n argocd)

#
# Log out
# argocd logout localhost:8080
#
# Log back in
# argocd login localhost:8080 --username admin --password <pass> --insecure
#
# Delete the initial passwd secret

## Create the app via CLI
#kubectl config set-context --current --namespace=argocd
#argocd app create will \
#	--repo https://github.com/047cburgess/iot-public.git \
#	--path ./ \
#	--dest-server https://kubernetes.default.svc \
#	--dest-namespace dev \
#	--sync-policy automated \
#	--auto-prune \
#	--self-heal
