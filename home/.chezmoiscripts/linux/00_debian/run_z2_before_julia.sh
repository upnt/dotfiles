#!/bin/bash
set -euo pipefail

LOG="/tmp/install_julia.log"

run() {
	local msg="$1"
	shift
	echo ".${msg}"
	"$@" >>"$LOG" 2>&1
}

trap 'echo "✖ エラー発生。ログ: $LOG"; tail -n 80 "$LOG"' ERR

# julia
export JULIAUP_ROOT="$HOME/.juliaup"
export PATH="$JULIAUP_ROOT/bin:$PATH"
if ! command -v juliaup >/dev/null 2>&1; then
	run "Installing Juliaup" sh -c '
		curl -fsSL https://install.julialang.org | sh -s -- -y
	'
fi
