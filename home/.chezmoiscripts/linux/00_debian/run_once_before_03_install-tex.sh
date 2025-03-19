#!/bin/bash

# texlive
mkdir -p "$HOME/.texlive"
if [ ! -d "$HOME/.texlive/2022" ]; then
	wget https://ftp.math.utah.edu/pub/tex/historic/systems/texlive/2022/install-tl-unx.tar.gz
	mkdir tmp-install-tl && tar xzvf install-tl-unx.tar.gz -C tmp-install-tl --strip-components 1
	cd tmp-tl-2022 || exit
	perl ./install-tl --scheme basic --no-interaction --texdir "$HOME/.texlive/2022"
	cd - || exit
	ls
	rm install-tl-unx.tar.gz
	rm -rf tmp-tl-2022
fi

if [ ! -d "$HOME/.texlive/latest" ]; then
	wget https://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz
	mkdir tmp-install-tl && tar xzvf install-tl-unx.tar.gz -C tmp-install-tl --strip-components 1
	cd tmp-tl-latest || exit
	perl ./install-tl --scheme basic --no-interaction --texdir "$HOME/.texlive/latest"
	cd - || exit
	rm install-tl-unx.tar.gz
	rm -rf tmp-tl-latest
fi
