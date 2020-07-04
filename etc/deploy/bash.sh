#!/usr/bin/bash
SCRIPT_DIR=$(cd $(dirname $0); pwd)
ln -sfnv $SCRIPT_DIR/../../.bashrc $HOME/.bashrc
ln -sfnv $SCRIPT_DIR/../../.bash_aliases $HOME/.bash_aliases
ln -sfnv $SCRIPT_DIR/../../.bash_profile $HOME/.bash_profile
