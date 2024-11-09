#!/bin/bash

# cpp
if [ -z "$(/usr/bin/which clang)" ]; then
	sudo bash -c "$(wget -O - https://apt.llvm.org/llvm.sh)"
fi

for cmd in clang clang++ lldb clangd lld; do
	if [ -z "$(/usr/bin/which "$cmd")" ]; then
		_latest=$(/usr/bin/ls /usr/bin | /usr/bin/grep -P "${cmd//+/\+}-\d+$" | sort -V | tail -n 1)
		if [ -n "$_latest" ]; then
			echo "$_latest -> /usr/bin/$cmd"
			sudo ln -s "$_latest" "/usr/bin/$cmd"
		fi
	fi
done

# python
if [ ! -d "$HOME/.pyenv" ]; then
	export PYENV_ROOT="$HOME/.pyenv"
	export PATH="$PYENV_ROOT/bin:$PATH"

	curl https://pyenv.run | bash
	eval "$(pyenv init -)"

	pyenv install 3.10
	pyenv global 3.10

	pip install poetry

	pyenv virtualenv 3.10 pynvim3
	pyenv activate pynvim3
	pip install -U pip
	pip install -U pynvim
fi

# nodejs
if [ ! -d "$HOME/.nodenv" ]; then
	git clone https://github.com/nodenv/nodenv.git ~/.nodenv
	cd ~/.nodenv && src/configure && make -C src
	export PATH="$HOME/.nodenv/bin:$PATH"
	git clone https://github.com/nodenv/node-build.git "$(nodenv root)"/plugins/node-build

	eval "$(nodenv init - zsh)"
	nodenv install 20.17.0
	nodenv global 20.17.0

	npm install -g @devcontainers/cli
	npm install -g prettier
	npm install -g neovim
fi

# ruby
if [ ! -d "$HOME/.rbenv" ]; then
	git clone https://github.com/rbenv/rbenv.git ~/.rbenv
	export PATH="$HOME/.rbenv/bin:$PATH"
	eval "$(rbenv init - zsh)"

	rbenv install 3.3.4
	rbenv global 3.3.4

	gem install neovim
fi

# lua
if [ ! -d "$HOME/.luaenv" ]; then
	git clone https://github.com/cehoffman/luaenv.git ~/.luaenv
	git clone https://github.com/cehoffman/lua-build.git ~/.luaenv/plugins/lua-build
	git clone https://github.com/xpol/luaenv-luarocks.git ~/.luaenv/plugins/luaenv-luarocks
	export PATH="$HOME/.luaenv/bin:$PATH"
	eval "$(luaenv init - zsh)"

	luaenv install 5.1.5
	luaenv global 5.1.5

	luaenv luarocks
fi

# golang (No goenv for backward compatibility)
if [ ! -d /usr/local/go ]; then
	cd /tmp || return
	wget https://go.dev/dl/go1.23.3.linux-amd64.tar.gz
	sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf go1.23.3.linux-amd64.tar.gz
	sudo rm /tmp/go1.23.3.linux-amd64.tar.gz
	export PATH=$PATH:/usr/local/go/bin

	go install github.com/dundee/gdu/v5/cmd/gdu@latest
	go install github.com/jesseduffield/lazygit@latest
	go install github.com/x-motemen/ghq@latest
fi

# perl
if [ ! -f /opt/perl-5.40.0/bin/perl ]; then
	cd /tmp || return
	wget https://www.cpan.org/src/5.0/perl-5.40.0.tar.gz
	tar -xzf perl-5.40.0.tar.gz
	cd perl-5.40.0 || return
	sudo ./Configure -des -Dprefix=/opt/perl-5.40.0
	make
	make test
	sudo make install
	sudo rm /tmp/perl-5.40.0.tar.gz
	sudo rm -rf /tmp/perl-5.40.0

	cpanm -n Neovim::Ext

	# texlive
	cd /tmp || return
	wget https://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz
	tar xvf install-tl-unx.tar.gz
	sudo rm /tmp/install-tl-unx.tar.gz
	sudo rm -rf /tmp/install-tl-unx
	cd install-tl-* || return
	/opt/perl-5.40.0/bin/perl ./install-tl
fi

# rust
if [ -z "$(/usr/bin/which rustup)" ]; then
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
	export PATH="$HOME/.cargo/bin:$PATH"
	cargo install lsd bat ripgrep bottom tree-sitter-cli git-delta fd-find zoxide --locked
fi

# asdf install java openjdk-21
# asdf install php 8.3.11
# asdf install julia 1.10.5
