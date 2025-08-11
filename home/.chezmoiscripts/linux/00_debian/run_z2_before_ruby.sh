#!/bin/bash

echo "Installing ruby"

# ruby
export RBENV_ROOT="$HOME/.rbenv"
if [ ! -d "$RBENV_ROOT" ]; then
	export PATH="$RBENV_ROOT/bin:$PATH"

	git clone https://github.com/rbenv/rbenv.git "$RBENV_ROOT"
	git clone https://github.com/rbenv/ruby-build.git "$RBENV_ROOT/plugins/ruby-build"
	git clone https://github.com/rkh/rbenv-update.git "$RBENV_ROOT/plugins/rbenv-update"
	eval "$(rbenv init - zsh)"

	rbenv install 3.3.4
	rbenv global 3.3.4

	gem install neovim
fi
