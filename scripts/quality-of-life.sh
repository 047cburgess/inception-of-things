#!/bin/bash

set -eu

# Remember original prompt
PROMPT='\[\e]0;\u@\h: \w\a\]${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
echo "export PROMPT='$PROMPT'" >> /etc/environment

# Can use kitty
echo "export TERM=xterm-256color" >> /etc/environment

# Aliases
echo "alias k=kubectl" >> /home/vagrant/.bashrc

# Hosts for part 2
echo '192.168.56.110   app1.com' >> /etc/hosts
echo '192.168.56.110   app2.com' >> /etc/hosts
echo '192.168.56.110   app3.com' >> /etc/hosts


# To avoid relogin after docker install
sudo addgroup docker 2>&1 || true
sudo adduser vagrant docker 2>&1 || true

# Add MOTD to ssh connections
source /etc/environment
printf "${C_BOLD_BLACK}
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢰${C_PINK}⣶⣤⠛⠉${C_BOLD_BLACK}
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣸⣇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣼⣿⣿⣧⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⣴⣿⣿⣿⣿⣿⣿⣦⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⢀⣀⣠⣤⣶⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣶⣤⣄⣀⡀⠀⠀⠀⠀${C_HOT_PINK}
⠀⠀⢸⣟⠛⠛⠛⢻⣿⡟⠛⠛⠛⢻⣿⣿⡟⠛⠛⠛⢻⣿⡟⠛⠛⠛⣻⡇⠀⠀
⠀⠀⢸⡿⢦⣤⣴⠞⣿⠻⣦⣤⡴⠟⢸⡇⠻⢦⣤⣴⠟⣿⠷⣦⣤⡴⢿⡇⠀⠀${C_PINK}
⠀⠀⢸⡇⠀⠀⠀⠀⣿⠀⠀⠀⠀⠀⢸⡇⠀⠀⠀⠀⠀⣿⠀⠀⠀⠀⢸⡇⠀⠀
⠀⠀⢸⡇⠀⠀⠀⢀⡿⠀⠀⠀⠀⠀⢸⡇⠀⠀⠀⠀⠀⢿⡀⠀⠀⠀⢸⡇⠀⠀
⠀⠀⣿⠀⠀⠀⠀⣸⠇⠀⠀⠀⠀⢠⡟⢻⡄⠀⠀⠀⠀⠸⣇⠀⠀⠀⠀⣿⠀⠀${C_LIGHT_PINK}
⠀⢰⡏⠀⠀⠀⢀⡿⠀⠀⠀⠀⢀⡾⠁⠈⢷⡀⠀⠀⠀⠀⢿⡀⠀⠀⠀⢹⡆⠀
⠀⣾⠃⠀⠀⠀⣼⠃⠀⠀⠀⢀⡾⠁⠀⠀⠈⢷⡀⠀⠀⠀⠘⣧⠀⠀⠀⠘⣷⠀${C_BLACK}
⠰⠿⠶⠶⠶⠶⠿⠶⠶⠶⠶⠿⠷⠶⠶⠶⠶⠾⠿⠶⠶⠶⠶⠿⠶⠶⠶⠶⠿⠇${C_RESET}
" > /etc/motd
sed -i '/pam_motd.so noupdate/s/^/#/' /etc/pam.d/sshd

# Add prefix to prompt
echo "export PS1='🎫  $PROMPT'" >> /home/vagrant/.bashrc
echo "Your 🎫 ticket for ExpoZoo is ready. Connect with 'make ssh'"

