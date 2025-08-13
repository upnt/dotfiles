#!/bin/bash

LOG="/tmp/install_perl.log"

run() {
	local msg="$1"
	shift
	echo ".${msg}"
	"$@" >>"$LOG" 2>&1
}

trap 'echo "✖ エラー発生。ログ: $LOG"; tail -n 80 "$LOG"' ERR

# perl
export PLENV_ROOT="$HOME/.plenv"
if [ ! -d "$PLENV_ROOT" ]; then
	export PATH="$PLENV_ROOT/bin:$PATH"

	git clone https://github.com/tokuhirom/plenv.git "$PLENV_ROOT"
	git clone https://github.com/tokuhirom/Perl-Build.git "$PLENV_ROOT/plugins/perl-build/"
	eval "$(plenv init -)"

	run "Installing perl 5.22" \
		plenv install 5.22.4
	plenv global 5.22.4
	plenv rehash
	run "Installing cpanm" \
		plenv install-cpanm
	plenv rehash

	run "Installing Neovim::Ext" \
		cpanm -n Neovim::Ext
fi
