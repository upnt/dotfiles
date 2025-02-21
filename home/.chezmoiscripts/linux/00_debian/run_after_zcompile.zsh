#!/usr/bin/env zsh

for file in ~/.zshenv ~/.zprofile ~/.zshrc ~/.zsh_functions/* 
do
  if [[ "$file" != *.zwc ]]; then
    echo "zcompile $file"
    zcompile "$file"
  fi
done
