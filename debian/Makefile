SHELL=/bin/bash

.PHONY: all
all: nvim zsh tmux latex zathura git requirements

nvim:
	-git clone https://github.com/upnt/nvim-myastro ~/.config/nvim 

zsh:
	-ln -s $(abspath ${CURDIR})/rc/zsh/.zshrc $(abspath ${HOME})/.zshrc
	-ln -s $(abspath ${CURDIR})/rc/zsh/.zsh_functions $(abspath ${HOME})/.zsh_functions

tmux:
	-ln -s $(abspath ${CURDIR})/rc/tmux/.tmux.conf $(abspath ${HOME})/.tmux.conf
	
latex:
	-ln -s $(abspath ${CURDIR})/rc/latex/.latexmkrc $(abspath ${HOME})/.latexmkrc

zathura:
	-ln -s $(abspath ${CURDIR})/rc/zathura $(abspath ${HOME})/.config

git:
	-ln -s $(abspath ${CURDIR})/rc/git/.gitconfig $(abspath ${HOME})/.gitconfig

alacritty:
	-ln -s $(abspath ${CURDIR})/rc/alacritty $(abspath ${HOME})/.config
	
requirements:
	sudo apt install build-essential zlib1g-dev libncurses5-dev \
		libgdbm-dev libnss3-dev libssl-dev libreadline-dev libffi-dev \
		libcurl4-openssl-dev libxml2-dev libjpeg-dev libonig-dev \
		libreadline-dev libzip-dev libtidy-dev libmcrypt-dev libxslt-dev \
		libbz2-dev libsqlite3-dev python3-tk liblzma-dev libyaml-dev ccache \
		wget xdg-utils cmake zathura xdotool zsh fzf tmux jq zathura
	
.PHONY: install
install: anyenv-install
	@echo
	@echo "Please reload your profile (exec $$SHELL -l) or open a new session.	"
	@echo "If you want envs, you exec (make install-envs)"

.PHONY: install-envs
install-envs: anyenv-install-envs
	@echo
	@echo "Please reload your profile (exec $$SHELL -l) or open a new session.	"
	@echo "If you want packages, you exec (make install-packages)"

.PHONY: install-packages
install-package: goenv-install-package luaenv-install-package nodenv-install-package plenv-install-package pyenv-install-package rbenv-install-package phpenv-install-package jenv-install-package

anyenv-install:
	-git clone https://github.com/anyenv/anyenv ~/.anyenv
	-~/.anyenv/bin/anyenv init
	-~/.anyenv/bin/anyenv install --init
	
anyenv-install-envs:
	mkdir -p $(shell anyenv root)/plugins
	-git clone https://github.com/znz/anyenv-update.git $(shell anyenv root)/plugins/anyenv-update
	-git clone https://github.com/znz/anyenv-git.git $(shell anyenv root)/plugins/anyenv-git
	-anyenv install goenv
	-anyenv install jenv
	-anyenv install luaenv
	-anyenv install nodenv
	-anyenv install plenv
	-anyenv install pyenv
	-anyenv install rbenv
	-anyenv install phpenv
	-curl https://sh.rustup.rs -sSf | sh
	-cargo install lsd bat ripgrep alacritty
	
goenv-install-package:
	-goenv install 1.22.6
	goenv global 1.22.6
	
jenv-install-package:
	sudo apt install openjdk-17-jdk
	-jenv add /usr/lib/jvm/java-17-openjdk-amd64
	-jenv global 17

luaenv-install-package:
	-git clone https://github.com/Sharparam/luaenv-update.git $(shell luaenv root)/plugins/luaenv-update
	-git clone https://github.com/xpol/luaenv-luarocks.git $(shell luaenv root)/plugins/luaenv-luarocks
	-luaenv install 5.1.5
	luaenv global 5.1.5
	-luaenv luarocks 2.4.3 
	
nodenv-install-package:
	-nodenv install 22.5.1	
	nodenv global 22.5.1
	
phpenv-install-package:
	-phpenv install 8.3.8
	phpenv global 8.3.8
	
plenv-install-package:
	-plenv install 5.40.0
	plenv global 5.40.0
	
pyenv-install-package:
	-mkdir -p $(shell pyenv root)/plugins
	-git clone https://github.com/pyenv/pyenv-virtualenv.git $(shell pyenv root)/plugins/pyenv-virtualenv
	-git clone https://github.com/pyenv/pyenv-ccache.git $(shell pyenv root)/plugins/pyenv-ccache
	-git clone https://github.com/pyenv/pyenv-update.git $(shell pyenv root)/plugins/pyenv-update
	-pyenv install 2
	-pyenv install 3.10
	pyenv global 3.10

rbenv-install-package:
	-rbenv install 3.3.4
	rbenv global 3.3.4

.PHONY: test
test: 

.PHONY: clean
clean:
	$(RM) -r ~/.config/nvim
	$(RM) ~/.zshrc
	$(RM) ~/.tmux.conf
