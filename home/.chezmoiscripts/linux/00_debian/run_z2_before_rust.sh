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
export PATH="$HOME/.cargo/bin:$PATH"
if ! command -v cargo >/dev/null 2>&1; then

	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
	run "Installing packages" \
		cargo install lsd bat ripgrep bottom git-delta fd-find
	run "Installing tree-sitter-cli" \
		cargo install tree-sitter-cli --version 0.25.10
fi
