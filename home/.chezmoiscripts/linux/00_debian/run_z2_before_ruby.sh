#!/bin/bash

LOG="/tmp/install_cpp.log"

run() {
	local msg="$1"
	shift
	echo ".${msg}"
	"$@" >>"$LOG" 2>&1
}

trap 'echo "✖ エラー発生。ログ: $LOG"; tail -n 80 "$LOG"' ERR

# ruby
export RBENV_ROOT="$HOME/.rbenv"
if [ ! -d "$RBENV_ROOT" ]; then
	export PATH="$RBENV_ROOT/bin:$PATH"

	git clone https://github.com/rbenv/rbenv.git "$RBENV_ROOT"
	git clone https://github.com/rbenv/ruby-build.git "$RBENV_ROOT/plugins/ruby-build"
	git clone https://github.com/rkh/rbenv-update.git "$RBENV_ROOT/plugins/rbenv-update"
	eval "$(rbenv init - zsh)"

	run "Installing ruby 3.3.4" \
		rbenv install 3.3.4
	rbenv global 3.3.4

	run "Installing neovim plugin on ruby 3.3.4" \
		gem install neovim
fi
