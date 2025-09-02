#!/bin/bash
set -euo pipefail

LOG="/tmp/updates.log"

run() {
  local msg="$1"
  shift
  echo ".${msg}"
  "$@" >>"$LOG" 2>&1
}

echo "Updating packages"
sudo apt-get update -yq
sudo apt-get upgrade -yq
sudo apt-get autoremove

if [ -d "$HOME/.tmux/bin" ]; then
  cd ~/.tmux/bin || exit 1
  git fetch

  LOCAL=$(git rev-parse HEAD)
  REMOTE=$(git rev-parse "@{u}")

  if [ "$LOCAL" != "$REMOTE" ]; then
    run "Updating tmux" \
      git pull
    run "autogen tmux" \
      sh autogen.sh
    run "configure tmux" \
      ./configure && run "compile tmux" make
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
    run "Update fzf" \
      git pull && ./install --bin
  else
    echo "fzf is already up to date"
  fi

  cd - || exit 1
fi
