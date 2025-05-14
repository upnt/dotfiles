#!/usr/bin/env zsh

echo "update packages"
sudo apt-get update
sudo apt-get full-upgrade -y
sudo apt-get autoremove

cd ~/.fzf && git pull && ./install --bin
cd - || return 0
