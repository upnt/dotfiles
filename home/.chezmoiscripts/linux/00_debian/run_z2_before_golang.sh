#!/bin/bash

echo "Installing golang"

# golang (No goenv for backward compatibility)
if [ ! -d /opt/go-1.12.3 ]; then
	export PATH="/opt/go-1.12.3/bin:$PATH"

	cd /tmp || exit 1
	wget https://go.dev/dl/go1.23.3.linux-amd64.tar.gz
	tar -xzf go1.23.3.linux-amd64.tar.gz
	sudo mv go /opt/go-1.12.3
	rm /tmp/go1.23.3.linux-amd64.tar.gz

	go install github.com/dundee/gdu/v5/cmd/gdu@latest
	go install github.com/jesseduffield/lazygit@latest
	go install github.com/x-motemen/ghq@latest
fi
