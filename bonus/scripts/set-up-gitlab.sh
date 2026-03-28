#!/bin/bash

set -eu
COLOR=$'🦊 \033[1;38;5;205m'
RESET=$' \033[0m'

if ! which helm ; then
	echo "$COLOR Installing helm. . .$RESET"
	curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-4
	chmod 700 get_helm.sh
	./get_helm.sh
	rm -f get_helm.sh
fi

if ! kubectl get services -n gitlab | grep gitlab-web ; then
  echo "$COLOR Installing gitlab$RESET"
  kubectl create namespace gitlab 2> /dev/null || true
  helm repo add gitlab https://charts.gitlab.io/
  
  helm repo update
  
  TIMEOUT=600s
  helm upgrade --install gitlab gitlab/gitlab \
    --timeout $TIMEOUT \
    -f ~/bonus/confs/values.yaml --namespace=gitlab 

  echo "$COLOR Waiting for Gitlab web service . . .$RESET"

  kubectl rollout status deployment \
    gitlab-webservice-default -n gitlab --timeout=$TIMEOUT
fi

# Extract the gitlab root password from kubernetes secret
GLAB_PASSWORD=$(kubectl -n gitlab get secret gitlab-gitlab-initial-root-password \
  -o jsonpath="{.data.password}" | base64 -d)
GLAB_USER=root

#echo "Gitlab instance Root Password: $GLAB_PASSWORD"
echo $GLAB_PASSWORD > ~/bonus/gitlab_root_password.txt
#echo "-- available in ~/bonus/gitlab_root_password.txt"

