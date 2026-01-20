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

# cpp
if [ -z "$(/usr/bin/which clang)" ]; then
	run "Downloading llvm" \
		wget https://apt.llvm.org/llvm.sh
	chmod +x llvm.sh
	run "Installing llvm" \
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
