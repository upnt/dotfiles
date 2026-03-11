#!/bin/bash
set -euo pipefail

LOG="/tmp/install_nodejs.log"

run() {
	local msg="$1"
	shift
	echo ".${msg}"
	"$@" >>"$LOG" 2>&1
}

# nodejs
export NODENV_ROOT="$HOME/.nodenv"
export PATH="$NODENV_ROOT/bin:$PATH"
if ! command -v nodenv >/dev/null 2>&1; then

	git clone https://github.com/nodenv/nodenv.git "$NODENV_ROOT"
	git clone https://github.com/nodenv/node-build.git "$NODENV_ROOT/plugins/node-build"
	git clone https://github.com/nodenv/nodenv-update.git "$NODENV_ROOT/plugins/nodenv-update"
	cd ~/.nodenv && src/configure && make -C src

	eval "$(nodenv init - zsh)"
	nodenv install 20.17.0
	nodenv global 20.17.0
fi

npm install -g @devcontainers/cli
npm install -g opencode-ai
npm install -g neovim
npm install -g @mermaid-js/mermaid-cli
