#!/usr/bin/bash
SCRIPT_DIR=$(cd $(dirname $0); pwd)
ln -sfnv $SCRIPT_DIR/../../.tmux.conf $HOME/.tmux.conf
ln -sfnv $SCRIPT_DIR/../../.tmux_plugins.conf $HOME/.tmux_plugins.conf
