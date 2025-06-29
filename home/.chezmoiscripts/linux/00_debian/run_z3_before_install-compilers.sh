#!/bin/bash

echo "install compilers"

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

if [ ! -d "/opt/boost" ]; then
	wget https://archives.boost.io/release/1.87.0/source/boost_1_87_0.tar.gz
	if [ "$(sha256sum boost_1_87_0.tar.gz | awk '{print $1}')" = "f55c340aa49763b1925ccf02b2e83f35fdcf634c9d5164a2acb87540173c741d" ]; then
		sudo tar xzf boost_1_87_0.tar.gz -C /opt
		cd /opt/boost_1_87_0 || return
		sudo ./bootstrap.sh
		sudo ./b2 install --prefix=/opt/boost
		cd - || return
	else
		echo "Invalid hash value for boost_1_87_0.tar.gz"
	fi
	rm boost_1_87_0.tar.gz
fi

# julia
export JULIAUP_ROOT="$HOME/.juliaup"
if [ ! -d "$JULIAUP_ROOT" ]; then
	curl -fsSL https://install.julialang.org | sh -s -- -y
fi

# rust
export RUSTUP_ROOT="$HOME/.rustup"
if [ ! -d "$RUSTUP_ROOT" ]; then
	export PATH="$HOME/.cargo/bin:$PATH"

	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
	cargo install lsd bat ripgrep bottom tree-sitter-cli git-delta fd-find --locked
fi

# php
if [ -z "$(which composer)" ]; then
	sudo apt-get install -y php-common php-mbstring libapache2-mod-php php-cli php-curl php-xml
	php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
	php -r "if (hash_file('sha384', 'composer-setup.php') === 'dac665fdc30fdd8ec78b38b9800061b4150413ff2e3b6f88543c636f7cd84f6db9189d43a81e5503cda447da73c7e5b6') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
	sudo php composer-setup.php --install-dir=/usr/local/bin --filename=composer
	php -r "unlink('composer-setup.php');"
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
