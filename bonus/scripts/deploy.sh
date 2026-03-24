#!/bin/bash 

set -u

echo 'Making sure the p3 cluster is already up'
k3d cluster start p3 || (k3d cluster delete p3 && bash ~/p3/scripts/deploy.sh)



echo 'Running set-up-gitlab.sh'
bash ~/bonus/scripts/set-up-gitlab.sh


cd ~/bonus/confs

USER=root
PASS=$(cat ../gitlab_root_password.txt)
REPO_NAME=bonus

if [ ! -d .git ] ; then
  echo 'Creating gitlab repository. . .'
  git init -b master
  git remote add origin "http://$USER:$PASS@gitlab.localhost:8081/$USER/$REPO_NAME"
  git add dev.yaml
  git commit -m "Initial Commit: yaml config for will app on gitlab"
  git push --force-with-lease -u origin master
else
  echo '.git exists, git push skipped.'
fi

echo 'Connecting argocd repo'
until argocd repo add http://gitlab-webservice-default.gitlab:8181/root/bonus.git \
	--username $USER --password $PASS 2>/dev/null ; do
	sleep 1
	echo -n .
done
echo 

echo 'Not Sleeping 5'
#sleep 5

echo Updating will app config to use new gitlab repo instead of github  . . .
kubectl apply -f ~/bonus/confs/app.yaml


echo waiting until app is healthy and synced  . . .
argocd app wait will --health --sync --timeout 300

echo 
echo "--------------------------------------------------------"
echo "Argocd User: admin"
echo "Argocd Pass: $(cat ~/p3/argocd_ad_pass.txt)"
echo "Access at: https://localhost:8080"

echo 
echo "--------------------------------------------------------"
echo "Gitlab User: $USER"
echo "Gitlab Pass: $PASS"
echo "Access at: http://gitlab-webservice-default.gitlab:8181"
echo "--------------------------------------------------------"
