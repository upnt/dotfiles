#!/bin/bash
set -euo pipefail

LOG="/tmp/install_rust.log"

run() {
	local msg="$1"
	shift
	echo ".${msg}"
	"$@" >>"$LOG" 2>&1
}

trap 'echo "✖ エラー発生。ログ: $LOG"; tail -n 80 "$LOG"' ERR

# rust
export RUSTUP_ROOT="$HOME/.rustup"
if [ ! -d "$RUSTUP_ROOT" ]; then
	export PATH="$HOME/.cargo/bin:$PATH"

	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
	run "Installing packages" \
		cargo install lsd bat ripgrep bottom git-delta fd-find
	run "Installing tree-sitter-cli" \
		cargo install tree-sitter-cli --version 0.25.10
fi
