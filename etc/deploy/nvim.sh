#! /bin/bash

if [ "$XDG_CONFIG_HOME" != "" ]; then
    RC_DIR=$XDG_CONFIG_HOME
elif [ "$(uname)" == 'Darwin' ]; then
    OS='Mac'
elif [ "$(expr substr $(uname -s) 1 5)" == 'Linux' ]; then
    RC_DIR="$HOME/.config"
elif [ "$(expr substr $(uname -s) 1 10)" == 'MINGW32_NT' ]; then
    OS='Cygwin'
elif [ "$OS" == "Windows_NT" ]; then 
    RC_DIR="$HOME/AppData/Local/.config" 
else
  echo "not support"
fi

SCRIPT_DIR=$(cd $(dirname $0); pwd)
rm -rf $RC_DIR/nvim
ln -sfnv $SCRIPT_DIR/../../nvim $RC_DIR/nvim
