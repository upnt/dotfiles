#!/bin/bash

LOG="/tmp/install_prerequirements.log"

run() {
	local msg="$1"
	shift
	echo ".${msg}"
	"$@" >>"$LOG" 2>&1
}

###################################
# Update packages.
run "Updating packages" \
	sudo apt-get update -y
run "Upgrading packages" \
	sudo apt-get upgrade -y

# Install pre-requisite packages.
run "Installing Prerequisites" \
	sudo apt-get install -y curl wget ca-certificates

# Install docker
sudo install -m 0755 -d /etc/apt/keyrings
run "Installing docker keyring" \
	sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc
echo \
	"deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" |
	sudo tee /etc/apt/sources.list.d/docker.list >/dev/null

# Install github cli
sudo mkdir -p -m 0755 /etc/apt/keyrings
run "Installing github-cli keyring" \
	wget -qO- https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo tee /etc/apt/keyrings/githubcli-archive-keyring.gpg >/dev/null
sudo chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list >/dev/null

# Reupdate packages.
run "Reupdating packages" \
	sudo apt-get update -y

# Install packages
sudo apt-get install -yq build-essential zlib1g-dev \
	libgdbm-dev libnss3-dev libssl-dev libffi-dev \
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
	libxcb-screensaver0-dev libxcb-keysyms1-dev libxcb-icccm4-dev libevent-dev ncurses-dev pkg-config \
	libxcb-util0-dev libxcb-glx0-dev libxcb-xrm-dev libxcb-xtest0-dev libtbb-dev \
	libx11-xcb-dev libglu1-mesa-dev libxrender-dev libxi-dev libxkbcommon-dev libxkbcommon-x11-dev \
	libxcomposite1 libxcursor1 libxi6 libxrandr2 libxtst6 libdbus-1-dev libssl-dev libzstd-dev \
	ccache zip unzip autoconf automake openssl gpg dirmngr gawk xdg-utils cmake ninja-build scdoc git gh \
	docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin maven \
	lsb-release software-properties-common gnupg zathura xdotool zsh jq zathura xsel tree
