#!/bin/bash

echo "Installing nodejs"

# nodejs
export NODENV_ROOT="$HOME/.nodenv"
if [ ! -d "$NODENV_ROOT" ]; then
	export PATH="$NODENV_ROOT/bin:$PATH"

	git clone https://github.com/nodenv/nodenv.git "$NODENV_ROOT"
	git clone https://github.com/nodenv/node-build.git "$NODENV_ROOT/plugins/node-build"
	git clone https://github.com/nodenv/nodenv-update.git "$NODENV_ROOT/plugins/nodenv-update"
	cd ~/.nodenv && src/configure && make -C src

	eval "$(nodenv init - zsh)"
	nodenv install 20.17.0
	nodenv global 20.17.0

	npm install -g @devcontainers/cli
	npm install -g prettier
	npm install -g neovim
fi
