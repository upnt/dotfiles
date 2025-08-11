#!/bin/bash

echo "Installing rust"

# rust
export RUSTUP_ROOT="$HOME/.rustup"
if [ ! -d "$RUSTUP_ROOT" ]; then
	export PATH="$HOME/.cargo/bin:$PATH"

	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
	cargo install lsd bat ripgrep bottom tree-sitter-cli git-delta fd-find --locked
fi
