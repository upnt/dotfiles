#!/bin/bash
set -euo pipefail

command -v zsh >/dev/null 2>&1 || exit 0
exec zsh "$0" "$@"

for file in ~/.local/zsh/.* ~/.local/zsh/.zsh_functions/* ~/.local/zsh_local/.*; do
  if [[ -f "$file" && "$file" != *.zwc && "$file" != *.zsh_history ]]; then
    echo "zcompile $file"
    zcompile "$file"
  fi
done
