#!/bin/bash 

set -eu
WHALE=$'🐋 \033[1;38;5;205m'
FOX=$'🦊 \033[1;38;5;205m'
OCTO=$'🐙 \033[1;38;5;205m'
RESET=$' \033[0m'

echo "$WHALE Making sure the p3 cluster is already up$RESET"
which k3d > /dev/null 2>&1 || bash ~/p3/scripts/deploy.sh
k3d cluster start p3 || (k3d cluster delete p3 && bash ~/p3/scripts/deploy.sh)



echo "$FOX Running set-up-gitlab.sh$RESET"
bash ~/bonus/scripts/set-up-gitlab.sh


mkdir -p ~/repo
cd ~/repo
cp ~/bonus/confs/dev.yaml .

USER=root
PASS=$(cat ~/bonus/gitlab_root_password.txt)
REPO_NAME=bonus

if [ ! -d .git ] ; then
  echo "$FOX Creating gitlab repository in ~/repo. . .$RESET"
  git init -b master
  git remote add origin "http://$USER:$PASS@gitlab.localhost:8081/$USER/$REPO_NAME"
  git add dev.yaml
  git commit -m "Initial Commit: yaml config for will app on gitlab"
  git push --force-with-lease -u origin master
else
  echo "$FOX .git exists, git push skipped.$RESET"
fi

echo "$OCTO Connecting argocd repo$RESET"
until argocd repo add http://gitlab-webservice-default.gitlab:8181/root/bonus.git \
	--username $USER --password $PASS 2>/dev/null ; do
	sleep 1
	echo -n .
done
echo 

echo "$WHALE Updating will app config to use new gitlab repo instead of github  . . .$RESET"
kubectl apply -f ~/bonus/confs/app.yaml


echo "$OCTO waiting until app is healthy and synced  . . .$RESET"
argocd app sync will
argocd app wait will --health --sync --timeout 300

echo 
echo "$OCTO ⣀⠔⠉⢏⣀⠔⠉⢏⣀⠔⠉⢏⣀⠔⠉⢏⣀⠔⠉⢏⣀⠔⠉⢏⣀⠔⠉⢏⣀⠔⠉⢏⣀⠔⠉⢏⣀⠔⠉⢏⣀⠔⠉⢏⣀⣀$RESET"
echo "$OCTO Argocd User: admin$RESET"
echo "$OCTO Argocd Pass: $(cat ~/p3/argocd_ad_pass.txt)$RESET"
echo "$OCTO Access at: https://localhost:8080$RESET"

echo
echo "$FOX ⣀⠔⠉⢏⣀⠔⠉⢏⣀⠔⠉⢏⣀⠔⠉⢏⣀⠔⠉⢏⣀⠔⠉⢏⣀⠔⠉⢏⣀⠔⠉⢏⣀⠔⠉⢏⣀⠔⠉⢏⣀⠔⠉⢏⣀⣀$RESET"
echo "$FOX Gitlab User: $USER$RESET"
echo "$FOX Gitlab Pass: $PASS$RESET"
echo "$FOX Access at: http://gitlab.localhost:8081$RESET"

echo
echo "$FOX ⣀⠔⠉⢏⣀⠔⠉⢏⣀⠔⠉⢏⣀⠔⠉⢏⣀⠔⠉⢏⣀⠔⠉⢏⣀⠔⠉⢏⣀⠔⠉⢏⣀⠔⠉⢏⣀⠔⠉⢏⣀⠔⠉⢏⣀⣀$RESET"
echo "$FOX Access web app at: http://localhost:8888$RESET"
echo "$FOX ⣀⠔⠉⢏⣀⠔⠉⢏⣀⠔⠉⢏⣀⠔⠉⢏⣀⠔⠉⢏⣀⠔⠉⢏⣀⠔⠉⢏⣀⠔⠉⢏⣀⠔⠉⢏⣀⠔⠉⢏⣀⠔⠉⢏⣀⣀$RESET"

eval echo -e "$WELCOME_BONUS"
