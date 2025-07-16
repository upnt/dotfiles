#!/bin/bash

echo "Install envs..."

# direnv
if [ -z "$(/usr/bin/which direnv)" ]; then
	curl -sfL https://direnv.net/install.sh | bash
fi

# python
export PYENV_ROOT="$HOME/.pyenv"
if [ ! -d "$PYENV_ROOT" ]; then
	export PATH="$PYENV_ROOT/bin:$PATH"

	git clone https://github.com/pyenv/pyenv.git "$PYENV_ROOT"
	git clone https://github.com/pyenv/pyenv-virtualenv.git "$PYENV_ROOT/plugins/pyenv-virtualenv"
	git clone https://github.com/pyenv/pyenv-ccache.git "$PYENV_ROOT/plugins/pyenv-ccache"
	git clone https://github.com/pyenv/pyenv-update.git "$PYENV_ROOT/plugins/pyenv-update"
	cd ~/.pyenv && src/configure && make -C src
	eval "$(pyenv init -)"
	eval "$(pyenv virtualenv-init -)"

	pyenv install 2.7
	pyenv install 3.12
	pyenv global 3.12

	pip install -U pip
	pip install -U poetry
	poetry config virtualenvs.in-project true
	poetry self add poetry-plugin-shell

	pyenv virtualenv 2.7 py2nvim
	pyenv activate py2nvim
	pip install -U pip
	pip install -U neovim
	pip install -U pynvim

	pyenv virtualenv 3.12 py3nvim
	pyenv activate py3nvim
	pip install -U pip
	pip install -U neovim
	pip install -U pynvim

	pyenv deactivate
fi

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

# lua
export LUAENV_ROOT="$HOME/.luaenv"
if [ ! -d "$LUAENV_ROOT" ]; then
	export PATH="$LUAENV_ROOT/bin:$PATH"

	git clone https://github.com/cehoffman/luaenv.git "$LUAENV_ROOT"
	git clone https://github.com/cehoffman/lua-build.git "$LUAENV_ROOT/plugins/lua-build"
	git clone https://github.com/xpol/luaenv-luarocks.git "$LUAENV_ROOT/plugins/luaenv-luarocks"
	git clone https://github.com/Sharparam/luaenv-update.git "$LUAENV_ROOT/plugins/luaenv-update"
	eval "$(luaenv init - zsh)"

	luaenv install 5.1.5
	luaenv global 5.1.5

	luaenv luarocks
fi

# java
# export JENV_ROOT="$HOME/.jenv"
# if [ ! -d "$JENV_ROOT" ]; then
# 	export PATH="$JENV_ROOT/bin:$PATH"
#
# 	git clone https://github.com/jenv/jenv.git "$JENV_ROOT"
# 	eval "$(jenv init -)"
#
# 	sudo apt-get install -y openjdk-21-jdk
# 	jenv add /usr/lib/jvm/java-21-openjdk-amd64
# 	jenv global 21
# 	jenv enable-plugin export
# fi

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

echo "Done."
