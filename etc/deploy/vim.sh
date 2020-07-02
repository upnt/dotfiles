#!/usr/bin/bash
if [ "$OS" == "Windows_NT" ]; then 
	RC_DIR="$HOME" 
elif [ "$OS" == "Linux" ]; then
	RC_DIR="$HOME"
fi 

SCRIPT_DIR=$(cd $(dirname $0); pwd)
rm -rf $RC_DIR/.vim
ln -sfnv $SCRIPT_DIR/../../.vim $RC_DIR/.vim
