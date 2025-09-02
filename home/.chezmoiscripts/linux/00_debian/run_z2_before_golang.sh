#!/bin/bash
set -euo pipefail

LOG="/tmp/install_go.log"

run() {
	local msg="$1"
	shift
	echo ".${msg}"
	"$@" >>"$LOG" 2>&1
}

trap 'echo "✖ エラー発生。ログ: $LOG"; tail -n 80 "$LOG"' ERR

# golang (No goenv for backward compatibility)
if [ ! -d /opt/go-1.12.3 ]; then
	export PATH="/opt/go-1.12.3/bin:$PATH"

	cd /tmp || exit 1
	run "Downloading Go 1.12.3" \
		wget https://go.dev/dl/go1.23.3.linux-amd64.tar.gz
	run "Extracting Go 1.12.3" \
		tar -xzf go1.23.3.linux-amd64.tar.gz
	sudo mv go /opt/go-1.12.3
	rm /tmp/go1.23.3.linux-amd64.tar.gz

	run "Installing gdu" \
		go install github.com/dundee/gdu/v5/cmd/gdu@latest
	run "Installing lazygit" \
		go install github.com/jesseduffield/lazygit@latest
	run "Installing ghq" \
		go install github.com/x-motemen/ghq@latest
fi
