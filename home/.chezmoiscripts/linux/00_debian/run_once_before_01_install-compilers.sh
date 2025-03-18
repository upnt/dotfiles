#!/bin/bash

# cpp
if [ -z "$(/usr/bin/which clang)" ]; then
	wget https://apt.llvm.org/llvm.sh
	chmod +x llvm.sh
	sudo ./llvm.sh all
	rm ./llvm.sh
	for cmd in clang clang++ lldb clangd lld; do
		if [ -z "$(/usr/bin/which "$cmd")" ]; then
			_latest=$(/usr/bin/ls /usr/bin | /usr/bin/grep -P "${cmd//+/\+}-\d+$" | sort -V | tail -n 1)
			if [ -n "$_latest" ]; then
				echo "$_latest -> /usr/bin/$cmd"
				sudo ln -s "$_latest" "/usr/bin/$cmd"
			fi
		fi
	done
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

# julia
export JULIAUP_ROOT="$HOME/.juliaup"
if [ ! -d "$JULIAUP_ROOT" ]; then
	curl -fsSL https://install.julialang.org | sh -s -- -y
fi

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

# rust
export RUSTUP_ROOT="$HOME/.rustup"
if [ ! -d "$RUSTUP_ROOT" ]; then
	export PATH="$HOME/.cargo/bin:$PATH"

	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
	cargo install lsd bat ripgrep bottom tree-sitter-cli git-delta fd-find zoxide --locked
fi

# php
if [ -z "$(which composer)" ]; then
	sudo apt-get install -y php-common php-mbstring libapache2-mod-php php-cli php-curl php-xml
	php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
	php -r "if (hash_file('sha384', 'composer-setup.php') === 'dac665fdc30fdd8ec78b38b9800061b4150413ff2e3b6f88543c636f7cd84f6db9189d43a81e5503cda447da73c7e5b6') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
	sudo php composer-setup.php --install-dir=/usr/local/bin --filename=composer
	php -r "unlink('composer-setup.php');"
fi

# texlive
mkdir -p "$HOME/.texlive"
if [ ! -d "$HOME/.texlive/latest" ]; then
	wget https://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz
	mkdir tmp-install-tl && tar xzvf install-tl-unx.tar.gz -C tmp-install-tl --strip-components 1
	cd tmp-install-tl || exit
	perl ./install-tl --scheme basic --no-interaction --texdir "$HOME/.texlive/latest"
	cd - || exit
	rm install-tl-unx.tar.gz
	rm -rf tmp-install-tl
fi

# golang (No goenv for backward compatibility)
if [ ! -d /opt/go-1.12.3 ]; then
	export PATH="/opt/go-1.12.3/bin:$PATH"

	cd /tmp || exit 1
	wget https://go.dev/dl/go1.23.3.linux-amd64.tar.gz
	tar -xzf go1.23.3.linux-amd64.tar.gz
	sudo mv go /opt/go-1.12.3
	rm /tmp/go1.23.3.linux-amd64.tar.gz

	go install github.com/dundee/gdu/v5/cmd/gdu@latest
	go install github.com/jesseduffield/lazygit@latest
	go install github.com/x-motemen/ghq@latest
fi

if [ ! -d "$HOME/.local/zsh_local" ]; then
	mkdir -p "$HOME/.local/zsh_local"
	touch "$HOME/.local/zsh_local/.zshenv"
	touch "$HOME/.local/zsh_local/.zshrc"
	touch "$HOME/.local/zsh_local/.zprofile"
fi
