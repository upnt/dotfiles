#!/usr/bin/bash
if [ "$XDG_CONFIG_HOME" != "" ]; then
	RC_DIR=$XDG_CONFIG_HOME
elif [ "$OS" == "Windows_NT" ]; then 
	RC_DIR="$HOME/AppData/Local" 
elif [ "$OS" == "Linux" ]; then
	RC_DIR="$HOME"
fi 

SCRIPT_DIR=$(cd $(dirname $0); pwd)
rm -rf $RC_DIR/nvim
ln -sfnv $SCRIPT_DIR/../../nvim $RC_DIR/nvim
