#!/usr/bin/env zsh

cd ~/.fzf && git pull && ./install --bin
cd - || return 0
