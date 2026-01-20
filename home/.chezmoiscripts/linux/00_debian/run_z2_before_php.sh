#!/bin/bash
set -euo pipefail

LOG="/tmp/install_php.log"

run() {
	local msg="$1"
	shift
	echo ".${msg}"
	"$@" >>"$LOG" 2>&1
}

trap 'echo "✖ エラー発生。ログ: $LOG"; tail -n 80 "$LOG"' ERR

# php
if [ -z "$(which composer)" ]; then
	sudo apt-get update
	sudo apt-get install -yqq php-common php-mbstring libapache2-mod-php php-cli php-curl php-xml

	run "Running Composer installer" \
		wget https://raw.githubusercontent.com/composer/getcomposer.org/681b090a0890b986ee0ae5862ca98db7c9170144/web/installer -O - -q | php -- --quiet
fi
