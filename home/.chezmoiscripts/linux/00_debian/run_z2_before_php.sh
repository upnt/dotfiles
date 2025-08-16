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
		php -r "if (hash_file('sha384', 'composer-setup.php') === 'dac665fdc30fdd8ec78b38b9800061b4150413ff2e3b6f88543c636f7cd84f6db9189d43a81e5503cda447da73c7e5b6') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
	run "Install Composer" \
		sudo php composer-setup.php --install-dir=/usr/local/bin --filename=composer
	run "Cleanup Composer installer" \
		php -r "unlink('composer-setup.php');"
fi
