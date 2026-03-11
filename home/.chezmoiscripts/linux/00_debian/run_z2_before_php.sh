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
if ! command -v composer >/dev/null 2>&1; then
	sudo apt-get update
	sudo apt-get install -yqq php-common php-mbstring libapache2-mod-php php-cli php-curl php-xml

	EXPECTED_CHECKSUM="$(php -r 'copy("https://composer.github.io/installer.sig", "php://stdout");')"
	php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
	ACTUAL_CHECKSUM="$(php -r "echo hash_file('sha384', 'composer-setup.php');")"
	
	if [ "$EXPECTED_CHECKSUM" != "$ACTUAL_CHECKSUM" ]
	then
	    >&2 echo 'ERROR: Invalid installer checksum'
	    rm composer-setup.php
	    exit 1
	fi
	
	php composer-setup.php --quiet
	mv composer.phar ~/.local/bin/composer
	rm composer-setup.php

fi
