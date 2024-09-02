#!/bin/bash

sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$UBUNTU_CODENAME") stable" | \
sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo add-apt-repository -y ppa:git-core/ppa

sudo apt update
sudo apt upgrade -yq

sudo apt install -y build-essential zlib1g-dev libncurses5-dev \
	libgdbm-dev libnss3-dev libssl-dev libreadline-dev libffi-dev \
	libcurl4-openssl-dev libxml2-dev libjpeg-dev libonig-dev \
	libreadline-dev libzip-dev libtidy-dev libmcrypt-dev libxslt-dev \
	libbz2-dev libsqlite3-dev tk-dev liblzma-dev libyaml-dev ccache \
	autoconf automake openssl gpg dirmngr gawk xdg-utils wget cmake scdoc git \
	docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin \
	zathura xdotool zsh fzf tmux jq zathura
	
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
sudo rm -rf /opt/nvim
sudo tar -C /opt -xzf nvim-linux64.tar.gz
rm nvim-linux64.tar.gz
git clone https://github.com/upnt/nvim-myastro ~/.config/nvim

git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.14.1
. "$HOME/.asdf/asdf.sh"

asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git
asdf plugin add lua    https://github.com/Stratus3D/asdf-lua
asdf plugin add python https://github.com/danhper/asdf-python
asdf plugin add go     https://github.com/asdf-community/asdf-golang
asdf plugin add perl   https://github.com/ouest/asdf-perl
asdf plugin add rust   https://github.com/code-lever/asdf-rust
asdf plugin add ruby   https://github.com/asdf-vm/asdf-ruby
asdf plugin add java   https://github.com/halcyon/asdf-java

asdf install nodejs 20.17.0
asdf install lua    5.1
asdf install python 3.10.14
asdf install go     latest
asdf install perl 	latest
asdf install rust 	latest
asdf install ruby 	latest
asdf install java 	openjdk-21

asdf reshim

pip install -U pip
pip install poetry
pip install pynvim
gem install neovim
npm install -g @devcontainers/cli
npm install -g prettier
npm install -g neovim
cpanm -n Neovim::Ext
cargo install lsd bat ripgrep alacritty bottom tree-sitter-cli git-delta
go install github.com/dundee/gdu/v5/cmd/gdu@latest
go install github.com/jesseduffield/lazygit@latest

asdf reshim

git clone https://github.com/alacritty/alacritty.git ~/alacritty

sudo ln -s $(which alacritty) /usr/local/bin
sudo cp ~/alacritty/extra/logo/alacritty-term.svg /usr/share/pixmaps/Alacritty.svg
sudo desktop-file-install ~/alacritty/extra/linux/Alacritty.desktop
sudo update-desktop-database

sudo mkdir -p /usr/local/share/man/man1
sudo mkdir -p /usr/local/share/man/man5

scdoc < ~/alacritty/extra/man/alacritty.1.scd | gzip -c | sudo tee /usr/local/share/man/man1/alacritty.1.gz > /dev/null
scdoc < ~/alacritty/extra/man/alacritty-msg.1.scd | gzip -c | sudo tee /usr/local/share/man/man1/alacritty-msg.1.gz > /dev/null
scdoc < ~/alacritty/extra/man/alacritty.5.scd | gzip -c | sudo tee /usr/local/share/man/man5/alacritty.5.gz > /dev/null
scdoc < ~/alacritty/extra/man/alacritty-bindings.5.scd | gzip -c | sudo tee /usr/local/share/man/man5/alacritty-bindings.5.gz > /dev/null

rm -rf ~/alacritty
