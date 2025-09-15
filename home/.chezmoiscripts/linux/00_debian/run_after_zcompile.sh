#!/bin/bash
set -euo pipefail

for file in ~/.local/zsh/.* ~/.local/zsh/.zsh_functions/* ~/.local/zsh_local/.*; do
  if [[ -f "$file" && "$file" != *.zwc && "$file" != *.zsh_history && "$file" != *.zcompdump ]]; then
    echo "zcompile $file"
    zsh -c "zcompile $file"
  fi
done
