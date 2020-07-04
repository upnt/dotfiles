SCRIPT_DIR=$(cd $(dirname $0); pwd)
bash $SCRIPT_DIR/etc/deploy/vim.sh
bash $SCRIPT_DIR/.config/deploy.sh
if type "bash" > /dev/null 2>&1; then
    bash $SCRIPT_DIR/etc/deploy/bash.sh
fi
if type "tmux" > /dev/null 2>&1; then
	bash $SCRIPT_DIR/etc/deploy/tmux.sh
fi

read -p "Hit enter: "
