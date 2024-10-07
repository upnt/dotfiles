#!/bin/bash

if [ -z "$(which asdf)" ]; then
	git clone https://github.com/asdf-vm/asdf.git ~/.asdf --depth 1 --single-branch -b v0.14.1
	# shellcheck source="/dev/null"
	source "$HOME/.asdf/asdf.sh"
fi

asdf plugin add lua https://github.com/Stratus3D/asdf-lua
asdf plugin add python https://github.com/danhper/asdf-python
asdf plugin add perl https://github.com/ouest/asdf-perl
asdf plugin add ruby https://github.com/asdf-vm/asdf-ruby
asdf plugin add rust https://github.com/code-lever/asdf-rust
asdf plugin add java https://github.com/halcyon/asdf-java
asdf plugin add go https://github.com/asdf-community/asdf-golang
asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git
asdf plugin add tinytex https://github.com/Fbrisset/asdf-tinytex.git
asdf plugin add php https://github.com/asdf-community/asdf-php.git
asdf plugin add julia https://github.com/rkyleg/asdf-julia.git

asdf install lua 5.1
asdf install python 3.10.14
asdf install perl 5.40.0
asdf install ruby 3.3.4
asdf install rust 1.80.1
asdf install java openjdk-21
asdf install go 1.23.0
asdf install nodejs 20.17.0
asdf install tinytex 2024.09
asdf install php 8.3.11
asdf install julia 1.10.5

asdf reshim

pip install poetry

mkdir -p "$HOME/.local/share/pynvim"
python3 -m venv "$HOME/.local/share/pynvim/.venv"
"$HOME/.local/share/pynvim/.venv/bin/pip" install -U pip
"$HOME/.local/share/pynvim/.venv/bin/pip" install -U pynvim
"$HOME/.local/share/pynvim/.venv/bin/pip" install -U neovim
gem install neovim

npm install -g @devcontainers/cli
npm install -g prettier
npm install -g neovim

cpanm -n Neovim::Ext
cargo install lsd bat ripgrep alacritty bottom tree-sitter-cli git-delta fd-find zoxide --locked

go install github.com/dundee/gdu/v5/cmd/gdu@latest
go install github.com/jesseduffield/lazygit@latest
go install github.com/x-motemen/ghq@latest

asdf reshim
