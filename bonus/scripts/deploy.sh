#!/bin/bash 

set -eu
COLOR=$'🦊 \033[38;5;219;48;5;198m'
RESET=$' \033[0m'

echo "$COLOR Making sure the p3 cluster is already up$RESET"
which k3d > /dev/null 2>&1 || bash ~/p3/scripts/deploy.sh
k3d cluster start p3 || (k3d cluster delete p3 && bash ~/p3/scripts/deploy.sh)



echo "$COLOR Running set-up-gitlab.sh$RESET"
bash ~/bonus/scripts/set-up-gitlab.sh


mkdir -p ~/repo
cd ~/repo
cp ~/bonus/confs/dev.yaml .

USER=root
PASS=$(cat ~/bonus/gitlab_root_password.txt)
REPO_NAME=bonus

if [ ! -d .git ] ; then
  echo "$COLOR Creating gitlab repository in ~/repo. . .$RESET"
  git init -b master
  git remote add origin "http://$USER:$PASS@gitlab.localhost:8081/$USER/$REPO_NAME"
  git add dev.yaml
  git commit -m "Initial Commit: yaml config for will app on gitlab"
  git push --force-with-lease -u origin master
else
  echo "$COLOR .git exists, git push skipped.$RESET"
fi

echo "$COLOR Connecting argocd repo$RESET"
until argocd repo add http://gitlab-webservice-default.gitlab:8181/root/bonus.git \
	--username $USER --password $PASS 2>/dev/null ; do
	sleep 1
	echo -n .
done
echo 

echo "$COLOR Updating will app config to use new gitlab repo instead of github  . . .$RESET"
kubectl apply -f ~/bonus/confs/app.yaml


echo "$COLOR waiting until app is healthy and synced  . . .$RESET"
argocd app wait will --health --sync --timeout 300

echo 
echo "$COLOR --------------------------------------------------------$RESET"
echo "$COLOR Argocd User: admin$RESET"
echo "$COLOR Argocd Pass: $(cat ~/p3/argocd_ad_pass.txt)$RESET"
echo "$COLOR Access at: https://localhost:8080$RESET"

echo
echo "$COLOR --------------------------------------------------------$RESET"
echo "$COLOR Gitlab User: $USER$RESET"
echo "$COLOR Gitlab Pass: $PASS$RESET"
echo "$COLOR Access at: http://gitlab-webservice-default.gitlab:8181$RESET"
echo "$COLOR --------------------------------------------------------$RESET"

echo -e "$WELCOME_BONUS"
