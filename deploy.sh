#! /bin/bash
SCRIPT_DIR=$(cd $(dirname $0); pwd)
if [ "$1" = "all" ]; then
    if type "vim" > /dev/null 2>&1; then
        bash $SCRIPT_DIR/etc/deploy/vim.sh
    fi
    if type "nvim" > /dev/null 2>&1; then
        bash $SCRIPT_DIR/etc/deploy/nvim.sh
    fi
    if type "bash" > /dev/null 2>&1; then
        bash $SCRIPT_DIR/etc/deploy/bash.sh
        echo "export PATH=$SCRIPT_DIR/bin:\$PATH" >> $SCRIPT_DIR/.bashrc
    fi
    if type "tmux" > /dev/null 2>&1; then
    	bash $SCRIPT_DIR/etc/deploy/tmux.sh
    fi
elif [ "$1" = "vim" ]; then
    bash $SCRIPT_DIR/etc/deploy/vim.sh
elif [ "$1" = "nvim" ]; then
    bash $SCRIPT_DIR/etc/deploy/nvim.sh
elif [ "$1" = "bash" ]; then
    bash $SCRIPT_DIR/etc/deploy/bash.sh
    echo "export PATH=$SCRIPT_DIR/bin:\$PATH" >> $SCRIPT_DIR/.bashrc
elif [ "$1" = "tmux" ]; then
    bash $SCRIPT_DIR/etc/deploy/tmux.sh
elif [ "$1" = "help" ]; then
    echo "command list"
    echo "  all"
    echo "  vim"
    echo "  nvim"
    echo "  bash"
    echo "  tmux"
    echo "  help"
else
    echo "$1 can't install"
fi
