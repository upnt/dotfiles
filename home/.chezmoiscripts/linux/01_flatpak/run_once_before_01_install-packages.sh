#!/bin/bash

sudo apt install flatpak gnome-software-plugin-flatpak

flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
flatpak install flathub io.github.zen_browser.zen

if [ -z "$(which goneovim)" ]; then
  wget https://github.com/akiyosi/goneovim/releases/download/v0.6.8/goneovim-v0.6.8-linux.tar.bz2 >/dev/null
  tar xvf goneovim-v0.6.8-linux.tar.bz2 >/dev/null
  sudo mv goneovim-v0.6.8-linux/goneovim /usr/local/bin/
  rm goneovim-v0.6.8-linux.tar.bz2
  rm -rf goneovim-v0.6.8-linux
fi

if [ -n "$(which update-desktop-database)" ]; then
  mkdir -p "$HOME/.local/share/applications/"
  if [ ! -f "$HOME/.local/share/applications/Alacritty.desktop" ]; then
    sudo ln -s "$(which alacritty)" /usr/bin/alacritty
    git clone https://github.com/alacritty/alacritty.git ~/alacritty --single-branch -b master --depth 1

    sudo ln -s "$(which alacritty)" /usr/local/bin
    sudo desktop-file-install ~/alacritty/extra/linux/Alacritty.desktop --dir="$HOME/.local/share/applications"

    sudo mkdir -p /usr/local/share/man/man1
    sudo mkdir -p /usr/local/share/man/man5

    scdoc <~/alacritty/extra/man/alacritty.1.scd | gzip -c | sudo tee /usr/local/share/man/man1/alacritty.1.gz >/dev/null
    scdoc <~/alacritty/extra/man/alacritty-msg.1.scd | gzip -c | sudo tee /usr/local/share/man/man1/alacritty-msg.1.gz >/dev/null
    scdoc <~/alacritty/extra/man/alacritty.5.scd | gzip -c | sudo tee /usr/local/share/man/man5/alacritty.5.gz >/dev/null
    scdoc <~/alacritty/extra/man/alacritty-bindings.5.scd | gzip -c | sudo tee /usr/local/share/man/man5/alacritty-bindings.5.gz >/dev/null

    rm -rf ~/alacritty
  fi

  if [ ! -f "$HOME/.local/share/applications/Goneovim.desktop" ]; then
    git clone https://github.com/akiyosi/goneovim.git ~/goneovim --single-branch -b master --depth 1
    mv ~/goneovim/cmd/goneovim/goneovim.desktop ~/goneovim/cmd/goneovim/Goneovim.desktop
    sudo desktop-file-install ~/goneovim/cmd/goneovim/Goneovim.desktop --dir="$HOME/.local/share/applications"

    rm -rf ~/goneovim
  fi
  sudo update-desktop-database ~/.local/share/applications -v
fi
