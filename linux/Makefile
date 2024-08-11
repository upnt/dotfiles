SHELL=/bin/bash

.PHONY: all
all: nvim zsh tmux

nvim:
	-git clone https://github.com/upnt/nvim-myastro ~/.config/nvim 

zsh:
	-ln -s $(abspath ${CURDIR})/rc/zsh/.zshrc $(abspath ${HOME})/.zshrc

tmux:
	-ln -s $(abspath ${CURDIR})/rc/tmux/.tmux.conf $(abspath ${HOME})/.tmux.conf
	
latex:
	-ln -s $(abspath ${CURDIR}/../global)/rc/latex/.latexmkrc $(abspath ${HOME})/.latexmkrc
	
.PHONY: install
install: requirements anyenv-install
	@echo
	@echo "Please reload your profile (exec $$SHELL -l) or open a new session.	"
	@echo "If you want envs, you exec (make install-envs)"

.PHONY: install-envs
install-envs: anyenv-install-envs
	@echo
	@echo "Please reload your profile (exec $$SHELL -l) or open a new session.	"
	@echo "If you want packages, you exec (make install-packages)"

.PHONY: install-packages
install-package: goenv-install-package luaenv-install-package nodenv-install-package plenv-install-package pyenv-install-package rbenv-install-package

requirements:
	sudo apt install build-essential zlib1g-dev libncurses5-dev \
		libgdbm-dev libnss3-dev libssl-dev libreadline-dev libffi-dev \
		libcurl4-openssl-dev libxml2-dev libjpeg-dev libonig-dev \
		libreadline-dev libzip-dev libtidy-dev libmcrypt-dev libxslt-dev \
		wget xdg-utils cmake zathura xdotool
	
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
	
goenv-install-package:
	goenv install 1.22.6

luaenv-install-package:
	-git clone https://github.com/Sharparam/luaenv-update.git $(shell luaenv root)/plugins/luaenv-update
	-git clone https://github.com/xpol/luaenv-luarocks.git $(shell luaenv root)/plugins/luaenv-luarocks
	-luaenv install 5.1.5
	luaenv global 5.1.5
	-luaenv luarocks 2.4.3 
	-luaenv luarocks 2.4.3 
	
nodenv-install-package:
	-nodenv install 22.5.1	
	noenv global 22.5.1
	
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
