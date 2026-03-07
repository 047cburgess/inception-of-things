#!/bin/bash

# See if OS has unofficial packages (should error if not)
#sudo apt remove $(dpkg --get-selections docker.io docker-compose docker-doc podman-docker containerd runc | cut -f1)

 curl -fsSL https://get.docker.com -o get-docker.sh
 sh get-docker.sh --dry-run
 