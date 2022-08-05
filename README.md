[![docker](https://github.com/upnt/dotfiles/actions/workflows/docker-publish.yml/badge.svg?branch=main)](https://github.com/upnt/dotfiles/actions/workflows/docker-publish.yml)
[![installer](https://github.com/upnt/dotfiles/actions/workflows/installer.yml/badge.svg)](https://github.com/upnt/dotfiles/actions/workflows/installer.yml)

# dotfiles
## features
This repository has below settings and makes it easy to set up windows and linux.
- editor
    - vim
    - neovim
- terminal
    - bash
    - powershell
- terminal emulator
    - alacritty
    - wezterm

## installations
### Windows

Create a frequently used Windows environment using chocolatey.

```powershell
Set-ExecutionPolicy Bypass -Scope Process -Force
./setup/choco-installer.ps1
cinst Boxstarter
```

Then enter `BOXSTARTERSHELL` to enter boxstarter shell and execute the following:

```BOXSTARTERSHELL
Install-BoxstarterPackage -PackageName https://gist.githubusercontent.com/upnt/64951a660a8d9ae23a8b224a2028475f/raw/boxstarter.ps1
```

Finally, execute the following to import the settings on powershell:
```powershell
./setup/rcinstaller.ps1
```

### Unix/Linux
Install requirements and import settings.
```bash
sudo apt update && sudo apt install curl unzip git
./setup/rcinstaller.sh
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
