#!/bin/bash

PROMPT='\[\e]0;\u@\h: \w\a\]${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '

echo "export PS1='🎫  $PROMPT'" >> /home/vagrant/.bashrc
echo "alias k=kubectl" >> /home/vagrant/.bashrc

echo "Your 🎫 ticket for ExpoZoo is ready. Connect with 'make ssh'"
