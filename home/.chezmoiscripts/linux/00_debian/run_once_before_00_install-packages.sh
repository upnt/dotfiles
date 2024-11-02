#!/bin/bash

# pwsh
###################################
# Prerequisites
# Install pre-requisite packages.
sudo apt-get update
sudo apt-get install -y curl wget

# Update the list of packages after we added packages.microsoft.com
sudo apt-get update

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

echo "apt update"
sudo apt-get update >/dev/null
echo "apt upgrade"
sudo apt-get upgrade -yq >/dev/null

echo "install pkgs..."
sudo apt-get install -y build-essential zlib1g-dev \
	libgdbm-dev libnss3-dev libssl-dev libreadline-dev libffi-dev \
	libcurl4-openssl-dev libxml2-dev libjpeg-dev libonig-dev \
	libreadline-dev libzip-dev libtidy-dev libmcrypt-dev libxslt1-dev \
	bison gettext libgd-dev libedit-dev libicu-dev libmysqlclient-dev \
	libpng-dev libpq-dev pkg-config re2c libbz2-dev libsqlite3-dev tk-dev \
	liblzma-dev libyaml-dev fontconfig libwayland-dev libwayland-egl-backend-dev wayland-scanner++ \
	libglu1-mesa-dev libpulse-dev libglib2.0-dev libnss3 libpci3 \
	libwayland-egl-backend-dev libwayland-egl++1 \
	libwayland-egl1 libwayland-egl1 libxcb-sync-dev \
	libxcb-damage0-dev libxcb-imdkit-dev libxcb-present-dev \
	libxcb-xfixes0-dev libxcb-xf86dri0-dev libxcb1-dev libxcb-composite0-dev \
	libxcb-xinerama0-dev libxcb-xv0-dev libxcb-dri3-dev libxcb-xkb-dev libxcb-image0-dev \
	libxcb-dri2-0-dev libxcb-util-dev libxcb-shm0-dev libxcb-res0-dev \
	libxcb-shape0-dev libxcb-render-util0-dev libxcb-xvmc0-dev libxcb-ewmh-dev libxcb-render0-dev \
	libxcb-cursor-dev libxcb-randr0-dev libxcb-xinput-dev libxcb-dpms0-dev libxcb-record0-dev \
	libxcb-screensaver0-dev libxcb-keysyms1-dev libxcb-icccm4-dev \
	libxcb-util0-dev libxcb-glx0-dev libxcb-xrm-dev libxcb-xtest0-dev \
	libx11-xcb-dev libglu1-mesa-dev libxrender-dev libxi-dev libxkbcommon-dev libxkbcommon-x11-dev \
	libxcomposite1 libxcursor1 libxi6 libxrandr2 libxtst6 libdbus-1-dev libssl-dev libzstd-dev \
	ccache zip unzip autoconf automake openssl gpg dirmngr gawk xdg-utils cmake scdoc git gh \
	docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin \
	python3.12-dev python3.12-venv zathura xdotool zsh fzf tmux jq zathura xsel

echo "installed"

current_shell=$(grep "^$(whoami)" /etc/passwd | cut -d":" -f7)

if [ "$current_shell" != "/usr/bin/zsh" ]; then
	chsh -s "$(which zsh)"
fi

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

if [ -z "$(which pwsh)" ]; then
	# Download the Microsoft repository GPG keys
	wget -P ~ https://github.com/PowerShell/PowerShell/releases/download/v7.4.6/powershell-lts_7.4.6-1.deb_amd64.deb

	# Register the Microsoft repository GPG keys
	sudo dpkg -i ~/powershell-lts_7.4.6-1.deb_amd64.deb

	sudo apt-get install -f

	# Delete the Microsoft repository GPG keys file
	rm ~/powershell-lts_7.4.6-1.deb_amd64.deb
fi

if [ -z "$(which clang)" ]; then
	sudo bash -c "$(wget -O - https://apt.llvm.org/llvm.sh)"
fi
