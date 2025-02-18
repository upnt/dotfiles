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
	libxcb-util0-dev libxcb-glx0-dev libxcb-xrm-dev libxcb-xtest0-dev libtbb-dev \
	libx11-xcb-dev libglu1-mesa-dev libxrender-dev libxi-dev libxkbcommon-dev libxkbcommon-x11-dev \
	libxcomposite1 libxcursor1 libxi6 libxrandr2 libxtst6 libdbus-1-dev libssl-dev libzstd-dev \
	ccache zip unzip autoconf automake openssl gpg dirmngr gawk xdg-utils cmake ninja-build scdoc git gh \
	docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin \
	lsb-release software-properties-common gnupg zathura xdotool zsh tmux jq zathura xsel tree
echo "installed"

current_shell=$(grep "^$(whoami)" /etc/passwd | cut -d":" -f7)

if [ "$current_shell" != "/usr/bin/zsh" ]; then
	chsh -s "$(/usr/bin/which zsh)"
fi

if [ -z "$(/usr/bin/which pwsh)" ]; then
	# Download the Microsoft repository GPG keys
	wget -P ~ https://github.com/PowerShell/PowerShell/releases/download/v7.4.6/powershell-lts_7.4.6-1.deb_amd64.deb

	# Register the Microsoft repository GPG keys
	sudo dpkg -i ~/powershell-lts_7.4.6-1.deb_amd64.deb

	sudo apt-get install -f

	# Delete the Microsoft repository GPG keys file
	rm ~/powershell-lts_7.4.6-1.deb_amd64.deb
fi

if [ ! -d "/opt/nvim-linux64" ]; then
	curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
	sudo tar -C /opt -xzf nvim-linux64.tar.gz
	rm nvim-linux64.tar.gz
fi

if [ ! -d "/opt/apache-maven-3.9.9" ]; then
	wget https://dlcdn.apache.org/maven/maven-3/3.9.9/binaries/apache-maven-3.9.9-bin.tar.gz
	sudo tar xzvf apache-maven-3.9.9-bin.tar.gz -C /opt
	rm apache-maven-3.9.9-bin.tar.gz
fi

if [ ! -d "/opt/boost" ]; then
	wget https://archives.boost.io/release/1.87.0/source/boost_1_87_0.tar.gz
	if [ "$(sha256sum boost_1_87_0.tar.gz | awk '{print $1}')" = "f55c340aa49763b1925ccf02b2e83f35fdcf634c9d5164a2acb87540173c741d" ]; then
		sudo tar xzvf boost_1_87_0.tar.gz -C /opt
		cd /opt/boost_1_87_0 || return
		sudo ./bootstrap.sh
		sudo ./b2 install --prefix=/opt/boost
		cd - || return
	else
		echo "Invalid hash value for boost_1_87_0.tar.gz"
	fi
	rm boost_1_87_0.tar.gz
fi

if [ ! -d "$HOME/.fzf" ]; then
	git clone --depth 1 https://github.com/junegunn/fzf.git "$HOME/.fzf"
	~/.fzf/install --bin
fi

if [ ! -d "$HOME/.pure" ]; then
	git clone --depth 1 https://github.com/sindresorhus/pure.git "$HOME/.pure"
fi

if [ -z "$(/usr/bin/which direnv)" ]; then
	curl -sfL https://direnv.net/install.sh | bash
fi
