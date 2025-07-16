#!/bin/bash
echo "Install packages..."
# setup
current_shell=$(grep "^$(whoami)" /etc/passwd | cut -d":" -f7)

if [ "$current_shell" != "/usr/bin/zsh" ]; then
	chsh -s "$(/usr/bin/which zsh)"
fi

# pwsh
if [ -z "$(/usr/bin/which pwsh)" ]; then
	sudo apt-get update -yqq
	# Download the Microsoft repository GPG keys
	wget -P ~ https://github.com/PowerShell/PowerShell/releases/download/v7.4.6/powershell-lts_7.4.6-1.deb_amd64.deb

	# Register the Microsoft repository GPG keys
	sudo dpkg -i ~/powershell-lts_7.4.6-1.deb_amd64.deb

	sudo apt-get install -f

	# Delete the Microsoft repository GPG keys file
	rm ~/powershell-lts_7.4.6-1.deb_amd64.deb
fi

# neovim
if [ ! -d "/opt/nvim-linux-x86_64" ]; then
	curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
	sudo rm -rf /opt/nvim
	sudo tar -C /opt -xzf nvim-linux-x86_64.tar.gz
	sudo rm nvim-linux-x86_64.tar.gz
fi

# zinit
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
if [ ! -d "$ZINIT_HOME" ]; then
	mkdir -p "$(dirname "$ZINIT_HOME")"
	git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
	source "$ZINIT_HOME/zinit.zsh"
fi

# tmux
if [ ! -d "$HOME/.tmux/bin" ]; then
	mkdir -p "$HOME/.tmux"
	git clone https://github.com/tmux/tmux.git "$HOME/.tmux/bin"
	cd "$HOME/.tmux/bin" || return 1
	sh autogen.sh
	./configure && make
	cd - || return 1
fi

# fzf
if [ ! -d "$HOME/.fzf" ]; then
	git clone --depth 1 https://github.com/junegunn/fzf.git "$HOME/.fzf"
	"$HOME/.fzf/install" --bin
fi
echo "Done."
