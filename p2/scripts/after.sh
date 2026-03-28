#!/bin/bash
set -eup
COLOR=$'🙊 \033[1;38;5;205m'
RESET=$' \033[0m'

echo "$COLOR Showing k3s configuration... $RESET"
echo
vagrant ssh caburgesS -c 'kubectl get all'

echo
eval echo -e "$WELCOME_P2"