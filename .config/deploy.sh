SCRIPT_DIR=$(cd $(dirname $0); pwd)
if type "nvim" > /dev/null 2>&1; then
  bash $SCRIPT_DIR/etc/deploy/nvim.sh
fi
