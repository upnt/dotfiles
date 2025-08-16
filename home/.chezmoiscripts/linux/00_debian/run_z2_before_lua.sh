#!/bin/bash
set -euo pipefail

LOG="/tmp/install_lua.log"

run() {
	local msg="$1"
	shift
	echo ".${msg}"
	"$@" >>"$LOG" 2>&1
}

trap 'echo "✖ エラー発生。ログ: $LOG"; tail -n 80 "$LOG"' ERR

# lua
export LUAENV_ROOT="$HOME/.luaenv"
if [ ! -d "$LUAENV_ROOT" ]; then
	export PATH="$LUAENV_ROOT/bin:$PATH"

	git clone https://github.com/cehoffman/luaenv.git "$LUAENV_ROOT"
	git clone https://github.com/cehoffman/lua-build.git "$LUAENV_ROOT/plugins/lua-build"
	git clone https://github.com/xpol/luaenv-luarocks.git "$LUAENV_ROOT/plugins/luaenv-luarocks"
	git clone https://github.com/Sharparam/luaenv-update.git "$LUAENV_ROOT/plugins/luaenv-update"
	eval "$(luaenv init - zsh)"

	run "Installing lua 5.1.5" \
		luaenv install 5.1.5
	luaenv global 5.1.5

	run "Installing lua 5.1.5 luarocks" \
		luaenv luarocks
fi
