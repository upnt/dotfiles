#!/bin/bash
set -euo pipefail

LOG="/tmp/install_golang.log"

run() {
	local msg="$1"
	shift
	echo ".${msg}"
	"$@" >>"$LOG" 2>&1
}

trap 'echo "✖ エラー発生。ログ: $LOG"; tail -n 80 "$LOG"' ERR

# golang (No goenv for backward compatibility)
VERSION="1.24.11"
GOROOT="/opt/go-${VERSION}"
export PATH="${GOROOT}/bin:$PATH"
if ! command -v go >/dev/null 2>&1; then

	cd /tmp || exit 1
	run "Downloading Go ${VERSION}" \
		wget "https://go.dev/dl/go${VERSION}.linux-amd64.tar.gz"
	run "Extracting Go ${VERSION}" \
		tar -xzf "go${VERSION}.linux-amd64.tar.gz"
	sudo mv go "${GOROOT}"
	rm "/tmp/go${VERSION}.linux-amd64.tar.gz"

	run "Installing lazygit" \
		go install github.com/jesseduffield/lazygit@latest
	run "installing lazydocker" \
		go install github.com/jesseduffield/lazydocker@latest
	run "Installing lazysql" \
		go install github.com/jorgerojas26/lazysql@latest
	run "Installing gdu" \
		go install github.com/dundee/gdu/v5/cmd/gdu@latest
	run "Installing ghq" \
		go install github.com/x-motemen/ghq@latest
fi
