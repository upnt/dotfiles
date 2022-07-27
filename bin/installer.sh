#!/bin/bash

in_array() {
    local arr
    eval arr=(${1})
	local i
	for i in "${arr[@]}"; do
		if [[ ${i} = ${2} ]]; then
			return 0
		fi
	done
	return 1
}

if [[ $# = 0 ]]; then
    echo "1: vim config"
    echo "2: neovim config"
    echo "3: dein"
    echo "4: deno"
    echo "5: bash"
    echo "6: powershell"
    echo "7: alacritty"
    echo -n "Chouse installation(ex. 2,3,4,5): "
    IFS="," read -a arr
else
    arr=$@
fi

if [[ ${#arr[@]} = 0 ]]; then
	exit 0
fi

# setup
mkdir tmp
git clone https://github.com/upnt/dotfiles.git tmp/dotfiles &> /dev/null


# install vimrc
if in_array "${arr[*]}" 1; then
    echo "Installing vimrc..."
    mkdir ~/.vim
    cp tmp/dotfiles/rc/vim/* ~/.vim
fi

# install neovimrc
if in_array "${arr[*]}" 2; then
    echo "Installing neovimrc..."
    mkdir -p ~/.config/nvim
    cp tmp/dotfiles/rc/nvim/* ~/.config/nvim
fi

# install dein.vim
if in_array "${arr[*]}" 3; then
    echo "Installing dein.vim..."
	curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > tmp/installer.sh
	sh tmp/installer.sh ~/.cache/dein &> /dev/null
fi

# install deno
if in_array "${arr[*]}" 4; then
    echo "Installing deno..."
    curl -fsSL https://deno.land/install.sh | sh
fi
 
# install bash
if in_array "${arr[*]}" 5; then
    echo "Installing bash configs..."
    cp -a tmp/dotfiles/rc/bash/. ~
fi

# install powershell
if in_array "${arr[*]}" 6; then
	if [[ -v $PROFILE ]]; then
        echo "Installing powershell configs..."
		cp -r tmp/dotfiles/rc/powershell/* `dirname $PROFILE`
	else
		echo "PROFILE is not set"
	fi
fi

# install alacritty
if in_array "${arr[*]}" 7; then
	if [[ -v $XDG_CONFIG_HOME ]]; then
        echo "Installing alacritty configs..."
        mkdir $XDG_CONFIG_HOME/alacritty
		cp -r tmp/dotfiles/rc/alacritty/* $XDG_CONFIG_HOME/alacritty
	else if [[ -v $APPDATA ]]; then
        mkdir $APPDATA/alacritty
		cp -r tmp/dotfiles/rc/alacritty/* $APPDATA/alacritty
	else
        echo "enable to find config directory"
    fi
fi

# remove
rm -rf tmp
