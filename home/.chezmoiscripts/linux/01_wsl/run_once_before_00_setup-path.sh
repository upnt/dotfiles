#!/bin/bash
set -euo pipefail

if [ -z "$(which clip)" ]; then
  sudo ln -s /mnt/c/Windows/system32/clip.exe /usr/local/bin/clip
fi

if [ -z "$(which clip.exe)" ]; then
  sudo ln -s /mnt/c/Windows/system32/clip.exe /usr/local/bin/clip.exe
fi

if [ -z "$(which docker)" ]; then
  sudo ln -s "/mnt/c/Program Files/Docker/Docker/resources/bin/docker.exe" /usr/local/bin/docker
fi

if [ -z "$(which docker.exe)" ]; then
  sudo ln -s "/mnt/c/Program Files/Docker/Docker/resources/bin/docker.exe" /usr/local/bin/docker.exe
fi
