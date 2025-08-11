#!/bin/bash

echo "Update packages..."
sudo apt-get update -yqq
sudo apt-get upgrade -yqq
sudo apt-get autoremove
echo "Done."

if [ -d "$HOME/.tmux/bin" ]; then
  cd ~/.tmux/bin || exit 1
  git fetch

  LOCAL=$(git rev-parse HEAD)
  REMOTE=$(git rev-parse "@{u}")

  if [ "$LOCAL" != "$REMOTE" ]; then
    echo "Update tmux..."
    git pull
    sh autogen.sh
    ./configure && make
    echo "Done."
  else
    echo "tmux is already up to date."
  fi

  cd - || exit 1
fi

if [ -d "$HOME/.fzf" ]; then
  cd ~/.fzf || exit 1
  git fetch

  LOCAL=$(git rev-parse HEAD)
  REMOTE=$(git rev-parse "@{u}")

  if [ "$LOCAL" != "$REMOTE" ]; then
    echo "Update fzf"
    git pull && ./install --bin
    echo "Done."
  else
    echo "fzf is already up to date"
  fi

  cd - || exit 1
fi
