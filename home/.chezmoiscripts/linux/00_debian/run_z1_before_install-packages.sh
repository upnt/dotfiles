#!/bin/bash
LOG="/tmp/ubuntu_install_packages.log"

run() {
	local msg="$1"
	shift
	echo ".${msg}"
	"$@" >>"$LOG" 2>&1
}
# setup
current_shell=$(grep "^$(whoami)" /etc/passwd | cut -d":" -f7)

if [ "$current_shell" != "/usr/bin/zsh" ]; then
	chsh -s "$(/usr/bin/which zsh)"
fi

# pwsh
if [ -z "$(/usr/bin/which pwsh)" ]; then
	sudo apt-get update -yqq
	# Download the Microsoft repository GPG keys
	run "Downloading pwsh" \
		wget -P ~ https://github.com/PowerShell/PowerShell/releases/download/v7.4.6/powershell-lts_7.4.6-1.deb_amd64.deb

	# Register the Microsoft repository GPG keys
	sudo dpkg -i ~/powershell-lts_7.4.6-1.deb_amd64.deb

	run "Installing pwsh" \
		sudo apt-get install -f

	# Delete the Microsoft repository GPG keys file
	rm ~/powershell-lts_7.4.6-1.deb_amd64.deb
fi

# neovim
if [ ! -d "/opt/nvim-linux-x86_64" ]; then
	run "Downloading neovim" \
		curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
	sudo rm -rf /opt/nvim
	run "Extracting neovim" \
		sudo tar -C /opt -xzf nvim-linux-x86_64.tar.gz
	sudo rm nvim-linux-x86_64.tar.gz
fi

# zinit
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
if [ ! -d "$ZINIT_HOME" ]; then
	mkdir -p "$(dirname "$ZINIT_HOME")"
	run "Downloading zinit" \
		git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
	run "Installing zinit" \
		source "$ZINIT_HOME/zinit.zsh"
fi

# tmux
if [ ! -d "$HOME/.tmux/bin" ]; then
	mkdir -p "$HOME/.tmux"
	run "Downloading tmux" \
		git clone https://github.com/tmux/tmux.git "$HOME/.tmux/bin"
	cd "$HOME/.tmux/bin" || return 1
	run "tmux autogen" \
		sh autogen.sh
	run "tmux configure" \
		./configure && make
	cd - || return 1
fi

if [ ! -d "$HOME/.tmux/scripts" ]; then
	mkdir -p "$HOME/.tmux/scripts"
	cat >"$HOME/.tmux/scripts/new-window.sh" <<'EOF'
#!/bin/zsh

fpath=(~/.local/zsh/.zsh_functions $fpath)
autoload -Uz ftm
ftm
EOF
	chmod u+x "$HOME/.tmux/scripts/new-window.sh"
fi

# fzf
if [ ! -d "$HOME/.fzf" ]; then
	run "Downloading fzf" \
		git clone --depth 1 https://github.com/junegunn/fzf.git "$HOME/.fzf"
	run "Installing fzf" \
		"$HOME/.fzf/install" --bin
fi

# direnv
if [ -z "$(/usr/bin/which direnv)" ]; then
	run "Installing direnv" \
		curl -sfL https://direnv.net/install.sh | bin_path="$HOME/.local/bin" bash
fi

if [ ! -d "$HOME/.local/zsh_local" ]; then
	mkdir -p "$HOME/.local/zsh_local"
	touch "$HOME/.local/zsh_local/.zshenv"
	touch "$HOME/.local/zsh_local/.zshrc"
	touch "$HOME/.local/zsh_local/.zprofile"
fi
