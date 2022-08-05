#!/bin/bash
cd `dirname $0`
cd ../

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
    echo "5: powershell"
    echo "6: alacritty"
    echo "7: wezterm"
    echo -n "Chouse installation(ex. 2,3,4,5): "
    read selector
else
    selector=$1
fi

IFS=" ,"
arr=($selector)

if [[ ${#arr[@]} = 0 ]]; then
	exit 0
fi

# install vimrc
if in_array "${arr[*]}" 1; then
    echo "Installing vimrc..."
    mkdir ~/.vim
    cp ./rc/vim/* ~/.vim
fi

# install neovimrc
if in_array "${arr[*]}" 2; then
    echo "Installing neovimrc..."
    mkdir -p ~/.config/nvim
    cp ./rc/nvim/* ~/.config/nvim
fi

# install dein.vim
if in_array "${arr[*]}" 3; then
    echo "Installing dein.vim..."
	curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh
	sh ./installer.sh ~/.cache/dein
    rm installer.sh
fi

# install deno
if in_array "${arr[*]}" 4; then
    echo "Installing deno..."
    curl -fsSL https://deno.land/install.sh | sh
fi
 
# install bash
if in_array "${arr[*]}" 5; then
    echo "Installing bash configs..."
    cp -a ./rc/bash/. ~
fi

# install alacritty
if in_array "${arr[*]}" 6; then
	if [[ -v $XDG_CONFIG_HOME ]]; then
        echo "Installing alacritty configs..."
        mkdir $XDG_CONFIG_HOME/alacritty
		cp -r ./rc/alacritty/* $XDG_CONFIG_HOME/alacritty
	elif [[ -v $APPDATA ]]; then
        mkdir $APPDATA/alacritty
		cp -r ./rc/alacritty/* $APPDATA/alacritty
	else
        echo "enable to find config directory"
    fi
fi

# install wezterm
if in_array "${arr[*]}" 7; then
    echo "Installing wezterm configs..."
	cp -r ./rc/wezterm/.wezterm.lua ~
fi
