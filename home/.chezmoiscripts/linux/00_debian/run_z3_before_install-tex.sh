#!/bin/bash

echo "install texlives"

# texlive
mkdir -p "$HOME/.texlive"
if [ ! -d "$HOME/.texlive/2022" ]; then
	_tmp_dir="tmp-tl-2022"
	wget https://ftp.math.utah.edu/pub/tex/historic/systems/texlive/2022/install-tl-unx.tar.gz
	mkdir "$_tmp_dir" && tar xzvf install-tl-unx.tar.gz -C "$_tmp_dir" --strip-components 1
	cd "$_tmp_dir" || exit
	env TEXDIR="$HOME/.texlive/2022" perl ./install-tl --scheme basic --no-gui --repository https://ftp.math.utah.edu/pub/tex/historic/systems/texlive/2022/tlnet-final/
	cd - || exit
	rm install-tl-unx.tar.gz
	rm -rf "$_tmp_dir"
fi

if [ ! -d "$HOME/.texlive/latest" ]; then
	_tmp_dir="tmp-tl-latest"
	wget https://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz
	mkdir "$_tmp_dir" && tar xzvf install-tl-unx.tar.gz -C "$_tmp_dir" --strip-components 1
	cd "$_tmp_dir" || exit
	perl ./install-tl --scheme basic --no-interaction --texdir "$HOME/.texlive/latest"
	cd - || exit
	rm install-tl-unx.tar.gz
	rm -rf "$_tmp_dir"
fi
