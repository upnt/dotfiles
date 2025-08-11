#!/bin/bash

echo "Installing lua"

# lua
export LUAENV_ROOT="$HOME/.luaenv"
if [ ! -d "$LUAENV_ROOT" ]; then
	export PATH="$LUAENV_ROOT/bin:$PATH"

	git clone https://github.com/cehoffman/luaenv.git "$LUAENV_ROOT"
	git clone https://github.com/cehoffman/lua-build.git "$LUAENV_ROOT/plugins/lua-build"
	git clone https://github.com/xpol/luaenv-luarocks.git "$LUAENV_ROOT/plugins/luaenv-luarocks"
	git clone https://github.com/Sharparam/luaenv-update.git "$LUAENV_ROOT/plugins/luaenv-update"
	eval "$(luaenv init - zsh)"

	luaenv install 5.1.5
	luaenv global 5.1.5

	luaenv luarocks
fi
