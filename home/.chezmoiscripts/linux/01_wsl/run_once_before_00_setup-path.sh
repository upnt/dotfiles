#!/bin/bash
set -euo pipefail

if [ -z "$(which clip.exe)" ]; then
  sudo ln -s /mnt/c/Windows/system32/clip.exe /usr/local/bin
fi
