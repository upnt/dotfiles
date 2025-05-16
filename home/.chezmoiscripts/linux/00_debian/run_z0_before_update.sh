#!/usr/bin/env zsh

echo "update packages"
sudo apt-get update
sudo apt-get full-upgrade -y
sudo apt-get autoremove

if [ -d "$HOME/.tmux/bin" ]; then
  cd ~/.tmux/bin || exit 1
  git fetch
  
  LOCAL=$(git rev-parse HEAD)
  REMOTE=$(git rev-parse @{u})

  if [ "$LOCAL" != "$REMOTE" ]; then
    echo "update tmux"
    git pull
    sh autogen.sh
    ./configure && make
  else
    echo "tmux is already up to date"
  fi
  
  cd - || exit 1
fi

if [ -d "$HOME/.fzf" ]; then
  cd ~/.fzf || exit 1
  git fetch
  
  LOCAL=$(git rev-parse HEAD)
  REMOTE=$(git rev-parse @{u})

  if [ "$LOCAL" != "$REMOTE" ]; then
    echo "update fzf"
    git pull && ./install --bin
  else
    echo "fzf is already up to date"
  fi
  
  cd - || exit 1
fi
