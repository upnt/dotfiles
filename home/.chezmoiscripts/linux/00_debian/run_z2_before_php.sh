#!/bin/bash
set -euo pipefail

LOG="/tmp/install_cpp.log"

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

	run "Download Composer installer" \
		php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
	run "Verify Composer installer" \
		php -r "if (hash_file('sha384', 'composer-setup.php') === 'ed0feb545ba87161262f2d45a633e34f591ebb3381f2e0063c345ebea4d228dd0043083717770234ec00c5a9f9593792') { echo 'Installer verified'.PHP_EOL; } else { echo 'Installer corrupt'.PHP_EOL; unlink('composer-setup.php'); exit(1); }"
	run "Install Composer" \
		php composer-setup.php
	run "Cleanup Composer installer" \
		php -r "unlink('composer-setup.php');"
fi
