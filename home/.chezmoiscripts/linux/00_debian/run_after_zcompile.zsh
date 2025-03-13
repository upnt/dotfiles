#!/usr/bin/env zsh

for file in ~/.zshenv ~/.local/zsh/.* ~/.local/zsh/.zsh_functions/* ~/.local/zsh_local/.*
do
  if [[ -f "$file" && "$file" != *.zwc ]]; then
    echo "zcompile $file"
    zcompile "$file"
  fi
done
