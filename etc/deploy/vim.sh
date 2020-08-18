SCRIPT_DIR=$(cd $(dirname $0); pwd)
rm -rf $HOME/.vim
ln -sfnv $SCRIPT_DIR/../../.vim $HOME/.vim
