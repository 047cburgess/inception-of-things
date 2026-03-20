#!/bin/bash

set -eu

helm repo add gitlab https://charts.gitlab.io/

helm repo update

helm upgrade --install gitlab gitlab/gitlab \
  --timeout 600s \
  -f confs/values.yaml --namespace=gitlab

kubectl rollout status deployment gitlab-webservice-default -n gitlab --timeout=300s

echo Waiting for Gitlab web service . . .
until curl -k http://gitlab.localhost:8081 >/dev/null 2>&1; do
  sleep 1
done

# Extract the gitlab root password from kubernetes secret
ROOT_PASSWORD=$(kubectl -n gitlab get secret gitlab-gitlab-initial-root-password \
  -o jsonpath="{.data.password}" | base64 -d)

echo "Gitlab instance Root Password: $ROOT_PASSWORD"
echo $ROOT_PASSWORD > gitlab_root_password.txt
echo "-- available in gitlab_root_password.txt"
