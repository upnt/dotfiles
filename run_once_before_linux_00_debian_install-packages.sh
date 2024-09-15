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
	liblzma-dev libyaml-dev qt5-default fontconfig libwayland-dev libwayland-egl++ wayland-scanner++ \
	libglu1-mesa-dev libpulse-dev libglib2.0-dev libasound2 libegl1-mesa libnss3 libpci3 libtiff5 \
	'^libxcb.*-dev' libx11-xcb-dev libglu1-mesa-dev libxrender-dev libxi-dev libxkbcommon-dev libxkbcommon-x11-dev \
	libxcomposite1 libxcursor1 libxi6 libxrandr2 libxtst6 libdbus-1-dev libssl-dev libzstd-dev \
	ccache zip unzip autoconf automake openssl gpg dirmngr gawk xdg-utils wget cmake scdoc git gh \
	docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin \
	zathura xdotool zsh fzf tmux jq zathura

if [ -z "$(which nvim)" ]; then
	curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
	sudo rm -rf /opt/nvim
	sudo tar -C /opt -xzf nvim-linux64.tar.gz
	rm nvim-linux64.tar.gz
fi

if [ -z "$(which git-remind)" ]; then
	wget https://github.com/suin/git-remind/releases/download/v1.1.1/git-remind_1.1.1_Linux_x86_64.tar.gz
	tar -C ~/.local/bin -xzf git-remind_1.1.1_Linux_x86_64.tar.gz
	rm git-remind_1.1.1_Linux_x86_64.tar.gz ~/.local/bin/README.md ~/.local/bin/LICENSE.md
fi
