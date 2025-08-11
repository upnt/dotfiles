#!/bin/bash

echo "Installing python"

# python
export PYENV_ROOT="$HOME/.pyenv"
if [ ! -d "$PYENV_ROOT" ]; then
	export PATH="$PYENV_ROOT/bin:$PATH"

	git clone https://github.com/pyenv/pyenv.git "$PYENV_ROOT"
	git clone https://github.com/pyenv/pyenv-virtualenv.git "$PYENV_ROOT/plugins/pyenv-virtualenv"
	git clone https://github.com/pyenv/pyenv-ccache.git "$PYENV_ROOT/plugins/pyenv-ccache"
	git clone https://github.com/pyenv/pyenv-update.git "$PYENV_ROOT/plugins/pyenv-update"
	cd ~/.pyenv && src/configure && make -C src
	eval "$(pyenv init -)"
	eval "$(pyenv virtualenv-init -)"

	pyenv install 2.7
	pyenv install 3.12
	pyenv global 3.12

	pip install -U pip
	pip install -U poetry
	poetry config virtualenvs.in-project true
	poetry self add poetry-plugin-shell

	pyenv virtualenv 2.7 py2nvim
	pyenv activate py2nvim
	pip install -U pip
	pip install -U neovim
	pip install -U pynvim

	pyenv virtualenv 3.12 py3nvim
	pyenv activate py3nvim
	pip install -U pip
	pip install -U neovim
	pip install -U pynvim

	pyenv deactivate
fi
