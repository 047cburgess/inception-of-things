#!/bin/bash 

set -euo pipefail
COLOR=$'🐋 \033[1;38;5;205m'
RESET=$' \033[0m'

sudo bash ~/p3/scripts/install-docker.sh
sudo bash ~/p3/scripts/install-k3d.sh

k3d cluster delete p3 2>/dev/null || true

echo "$COLOR Creating p3 cluster . . .$RESET"
echo "$COLOR Setting up p8888 forwarding for will app . . .$RESET"
k3d cluster create p3 \
  -p "8888:30000@loadbalancer" \
  -p "8080:30001@loadbalancer" \
  -p "8081:32080@loadbalancer"

COLOR=$'🐙 \033[1;38;5;205m'

echo "$COLOR Creating argocd and dev namespaces . . .$RESET"
kubectl create namespace argocd
kubectl create namespace dev

echo "$COLOR Downloading and applying argocd yaml from official docs . . .$RESET"
kubectl apply -n argocd --server-side --force-conflicts \
  -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

echo "$COLOR Waiting for Argo CD server to be ready. . .$RESET"
kubectl rollout status deployment argocd-server -n argocd --timeout=300s

echo "$COLOR Creating port forwarding for argocd-server 8080-443 . . .$RESET"
kubectl patch svc argocd-server -n argocd \
  -p '{"spec":{"type":"NodePort","ports":[{"port":80,"targetPort":8080,"nodePort":30001}]}}'
echo "$COLOR Ready! Available at https://localhost:8080$RESET"

echo "$COLOR Waiting for ArgoCD API . . .$RESET"
until curl -k http://localhost:8080 >/dev/null 2>&1; do
  sleep 3
done

echo "$COLOR Extracting initial argocd password . . .$RESET"
ARGOCD_ADMIN_PASSWORD=$(kubectl -n argocd get secret argocd-initial-admin-secret \
  -o jsonpath="{.data.password}" | base64 -d)
ARGOCD_ADMIN_USER=admin

echo
echo "$COLOR ARGOCD admin password: ${ARGOCD_ADMIN_PASSWORD}$RESET"
echo "$COLOR Available in ~/p3/argocd_ad_pass.txt$RESET"
echo "$ARGOCD_ADMIN_PASSWORD" > ~/p3/argocd_ad_pass.txt

echo "$COLOR Logging in to argocd . . .$RESET"

argocd login localhost:8080 \
  --username $ARGOCD_ADMIN_USER \
  --password "${ARGOCD_ADMIN_PASSWORD}" \
  --insecure \
  --grpc-web

echo "$COLOR Deleting the argocd password kubectl secret. . .$RESET"
kubectl -n argocd delete secret argocd-initial-admin-secret

echo "$COLOR Applying the app.yaml config . . .$RESET"
kubectl apply -f ~/p3/confs/app.yaml


argocd app wait will --health --sync --timeout 300

# View the status of the application
echo 
echo "$COLOR --------------------------------------------------------$RESET"
echo "$COLOR Argocd User: $ARGOCD_ADMIN_USER$RESET"
echo "$COLOR Argocd Pass: $ARGOCD_ADMIN_PASSWORD$RESET"
echo "$COLOR Access at: https://localhost:8080$RESET"

eval echo -e "$WELCOME_P3"
