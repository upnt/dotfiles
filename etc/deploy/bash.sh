#! /bin/bash
SCRIPT_DIR=$(cd $(dirname $0); pwd)
ln -sfnv $SCRIPT_DIR/../../.inputrc $HOME
ln -sfnv $SCRIPT_DIR/../../.bashrc $HOME
ln -sfnv $SCRIPT_DIR/../../.bash_aliases $HOME
