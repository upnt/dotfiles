[![docker](https://github.com/upnt/dotfiles/actions/workflows/docker-publish.yml/badge.svg?branch=main)](https://github.com/upnt/dotfiles/actions/workflows/docker-publish.yml)
[![installer](https://github.com/upnt/dotfiles/actions/workflows/installer.yml/badge.svg)](https://github.com/upnt/dotfiles/actions/workflows/installer.yml)

# dotfiles
## features
This repository has below settings.
- editor
    - vim
    - neovim
- terminal
    - bash
    - powershell
- terminal emulator
    - alacritty
    - wezterm

## install
For Unix/Linux
```bash
sudo apt update && sudo apt install curl unzip git
./installer.sh
```

Enable to install following configrations:
- [x] small vim configuration
- [x] neovim configuration
- [x] dein.vim
- [x] deno
- [x] bash profile
- [x] powershell profile
- [ ] alacritty config
- [ ] wezterm config

## docker
If you want to try this repository, you can use the following packages.
- [myvim-docker](https://github.com/upnt/dotfiles/pkgs/container/myvim-docker)
  - you can use vimrc
- [mynvim-docker](https://github.com/upnt/dotfiles/pkgs/container/mynvim-docker)
  - you can use neovim configs
