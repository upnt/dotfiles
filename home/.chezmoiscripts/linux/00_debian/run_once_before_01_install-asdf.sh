#!/bin/bash

if [ -z "$(/usr/bin/which pyenv)" ]; then
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

if [ -z "$(/usr/bin/which go)" ]; then
	wget https://go.dev/dl/go1.23.3.linux-amd64.tar.gz
	sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf go1.23.3.linux-amd64.tar.gz
	export PATH=$PATH:/usr/local/go/bin
fi

# asdf install lua 5.1
# asdf install perl 5.40.0
# asdf install ruby 3.3.4
# asdf install rust 1.80.1
# asdf install java openjdk-21
# asdf install go 1.23.0
# asdf install nodejs 20.17.0
# asdf install tinytex 2024.09
# asdf install php 8.3.11
# asdf install julia 1.10.5

# gem install neovim
# 
# npm install -g @devcontainers/cli
# npm install -g prettier
# npm install -g neovim
# 
# cpanm -n Neovim::Ext
# cargo install lsd bat ripgrep alacritty bottom tree-sitter-cli git-delta fd-find zoxide --locked

go install github.com/dundee/gdu/v5/cmd/gdu@latest
go install github.com/jesseduffield/lazygit@latest
go install github.com/x-motemen/ghq@latest
