#!/bin/bash

echo "Installing perl"

# perl
export PLENV_ROOT="$HOME/.plenv"
if [ ! -d "$PLENV_ROOT" ]; then
	export PATH="$PLENV_ROOT/bin:$PATH"

	git clone https://github.com/tokuhirom/plenv.git "$PLENV_ROOT"
	git clone https://github.com/tokuhirom/Perl-Build.git "$PLENV_ROOT/plugins/perl-build/"
	eval "$(plenv init -)"

	plenv install 5.22.4
	plenv global 5.22.4
	plenv rehash
	plenv install-cpanm
	plenv rehash

	cpanm -n Neovim::Ext
fi
