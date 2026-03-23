#!/bin/bash 

# Need to add proper error handling and condition checks

 echo 'Make sure the cluster is up'
k3d cluster start p3 || (k3d cluster delete p3 && bash ~/p3/deploy.sh)

echo Setting up port forwarding . . .
k3d cluster edit p3 --port-add 8081:32080@loadbalancer || k3d cluster start p3

kubectl create namespace gitlab

echo Waiting for Argo CD server to be ready. . .
kubectl rollout status deployment argocd-server -n argocd --timeout=300s


echo 'Applying Helm gitlab script up.sh'
bash ~/bonus/up.sh


cd ~/bonus/confs

USER=root
PASS=$(cat ../gitlab_root_password.txt)
REPO_NAME=bonus

rm -rf .git
git init -b master
git remote add origin "http://$USER:$PASS@gitlab.localhost:8081/$USER/$REPO_NAME"
git add dev.yaml
git commit -m "Initial Commit: yaml config for will app on gitlab"
git push --force-with -u origin master

echo 'connecting argocd repo'
argocd repo add http://gitlab-webservice-default.gitlab:8181/root/bonus.git \
	--username $USER --password $PASS
sleep 5

echo Updating will  . . .
kubectl apply -f ~/bonus/confs/app.yaml


echo Manually syncing application will  . . .
argocd app sync will
# View the status of the application
argocd app get will
