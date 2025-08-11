#!/bin/bash

echo "Installing cpp"

# cpp
if [ -z "$(/usr/bin/which clang)" ]; then
	wget https://apt.llvm.org/llvm.sh
	chmod +x llvm.sh
	sudo ./llvm.sh all
	rm ./llvm.sh
	for cmd in clang clang++ lldb clangd lld; do
		if [ -z "$(/usr/bin/which "$cmd")" ]; then
			_latest=$(/usr/bin/ls /usr/bin | /usr/bin/grep -P "${cmd//+/\+}-\d+$" | sort -V | tail -n 1)
			if [ -n "$_latest" ]; then
				echo "$_latest -> /usr/bin/$cmd"
				sudo ln -s "$_latest" "/usr/bin/$cmd"
			fi
		fi
	done
fi

if [ ! -d "/opt/boost" ]; then
	wget https://archives.boost.io/release/1.87.0/source/boost_1_87_0.tar.gz
	if [ "$(sha256sum boost_1_87_0.tar.gz | awk '{print $1}')" = "f55c340aa49763b1925ccf02b2e83f35fdcf634c9d5164a2acb87540173c741d" ]; then
		sudo tar xzf boost_1_87_0.tar.gz -C /opt
		cd /opt/boost_1_87_0 || return
		sudo ./bootstrap.sh
		sudo ./b2 install --prefix=/opt/boost
		cd - || return
	else
		echo "Invalid hash value for boost_1_87_0.tar.gz"
	fi
	rm boost_1_87_0.tar.gz
fi
