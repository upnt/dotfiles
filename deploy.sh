SCRIPT_DIR=$(cd $(dirname $0); pwd)
bash $SCRIPT_DIR/etc/deploy/*.sh
bash $SCRIPT_DIR/.config/deploy.sh

read -p "Hit enter: "
