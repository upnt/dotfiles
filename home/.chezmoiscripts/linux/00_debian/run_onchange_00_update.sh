#!/bin/bash

echo "update packages"
sudo apt-get update
sudo apt-get full-upgrade -y
sudo apt-get autoremove
