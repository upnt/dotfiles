#!/bin/bash

# docker
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc
echo \
	"deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$UBUNTU_CODENAME") stable" |
	sudo tee /etc/apt/sources.list.d/docker.list >/dev/null

# github cli
(type -p wget >/dev/null || (sudo apt-get update && sudo apt-get install wget -y))
sudo mkdir -p -m 755 /etc/apt/keyrings
wget -qO- https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo tee /etc/apt/keyrings/githubcli-archive-keyring.gpg >/dev/null
sudo chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list >/dev/null

sudo apt-get update
sudo apt-get upgrade -yq

sudo apt-get install -y build-essential zlib1g-dev libncurses5-dev \
	libgdbm-dev libnss3-dev libssl-dev libreadline-dev libffi-dev \
	libcurl4-openssl-dev libxml2-dev libjpeg-dev libonig-dev \
	libreadline-dev libzip-dev libtidy-dev libmcrypt-dev libxslt-dev \
	bison gettext libgd-dev libedit-dev libicu-dev libmysqlclient-dev \
	libpng-dev libpq-dev pkg-config re2c libbz2-dev libsqlite3-dev tk-dev \
	liblzma-dev libyaml-dev ccache zip unzip autoconf automake openssl \
	gpg dirmngr gawk xdg-utils wget cmake scdoc git gh \
	docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin \
	zathura xdotool zsh fzf tmux jq zathura

curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
sudo rm -rf /opt/nvim
sudo tar -C /opt -xzf nvim-linux64.tar.gz
rm nvim-linux64.tar.gz

git clone https://github.com/asdf-vm/asdf.git ~/.asdf --depth 1 --single-branch -b v0.14.1
. "$HOME/.asdf/asdf.sh"

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
cargo install lsd bat ripgrep alacritty bottom tree-sitter-cli git-delta fd-find
go install github.com/dundee/gdu/v5/cmd/gdu@latest
go install github.com/jesseduffield/lazygit@latest

asdf reshim

git clone https://github.com/alacritty/alacritty.git ~/alacritty --single-branch -b master --depth 1

sudo ln -s "$(which alacritty)" /usr/local/bin
sudo cp ~/alacritty/extra/logo/alacritty-term.svg /usr/share/pixmaps/Alacritty.svg
sudo desktop-file-install ~/alacritty/extra/linux/Alacritty.desktop
sudo update-desktop-database

sudo mkdir -p /usr/local/share/man/man1
sudo mkdir -p /usr/local/share/man/man5

scdoc <~/alacritty/extra/man/alacritty.1.scd | gzip -c | sudo tee /usr/local/share/man/man1/alacritty.1.gz >/dev/null
scdoc <~/alacritty/extra/man/alacritty-msg.1.scd | gzip -c | sudo tee /usr/local/share/man/man1/alacritty-msg.1.gz >/dev/null
scdoc <~/alacritty/extra/man/alacritty.5.scd | gzip -c | sudo tee /usr/local/share/man/man5/alacritty.5.gz >/dev/null
scdoc <~/alacritty/extra/man/alacritty-bindings.5.scd | gzip -c | sudo tee /usr/local/share/man/man5/alacritty-bindings.5.gz >/dev/null

rm -rf ~/alacritty
