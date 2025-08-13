#!/bin/bash

LOG="/tmp/install_python.log"

run() {
	local msg="$1"
	shift
	echo ".${msg}"
	"$@" >>"$LOG" 2>&1
}

trap 'echo "✖ エラー発生。ログ: $LOG"; tail -n 80 "$LOG"' ERR

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

	run "Installing python 2.7" \
		pyenv install 2.7
	run "Installing python 3.12" \
		pyenv install 3.12
	pyenv global 3.12

	run "Update pip" \
		pip install -U pip
	run "Install poetry" \
		pip install -U poetry
	poetry config virtualenvs.in-project true
	run "Install poetry shell" \
		poetry self add poetry-plugin-shell

	pyenv virtualenv 2.7 py2nvim
	pyenv activate py2nvim
	pip install -U pip
	run "Install neovim plugin on python 2.7" \
		pip install -U neovim
	run "Install pynvim plugin on python 2.7" \
		pip install -U pynvim

	pyenv virtualenv 3.12 py3nvim
	pyenv activate py3nvim
	pip install -U pip
	run "Install neovim plugin on python 3.12" \
		pip install -U neovim
	run "Install pynvim plugin on python 3.12" \
		pip install -U pynvim

	pyenv deactivate
fi
