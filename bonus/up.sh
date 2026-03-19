#!/bin/bash

set -eu

helm repo add gitlab https://charts.gitlab.io/

helm repo update

helm upgrade --install gitlab gitlab/gitlab \
  --timeout 600s \
  -f values.yaml --namespace=gitlab

