[![myvim](https://github.com/upnt/dotfiles/actions/workflows/myvim-publish.yml/badge.svg)](https://github.com/upnt/dotfiles/actions/workflows/myvim-publish.yml)
[![mynvim](https://github.com/upnt/dotfiles/actions/workflows/mynvim-publish.yml/badge.svg)](https://github.com/upnt/dotfiles/actions/workflows/mynvim-publish.yml)
[![rcinstaller](https://github.com/upnt/dotfiles/actions/workflows/rcinstaller.yml/badge.svg)](https://github.com/upnt/dotfiles/actions/workflows/rcinstaller.yml)
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
Enable to install following configrations and dependences:
- [x] vim configuration
- [x] neovim configuration
- [x] dein.vim
- [x] deno
- [x] terminal profile
- [x] alacritty configuration
- [x] wezterm configuration

### Windows

Create a frequently used Windows environment using chocolatey.

```powershell
Set-ExecutionPolicy Bypass -Scope Process -Force
.\setup\choco-installer.ps1
cinst Boxstarter
```

Then enter `BOXSTARTERSHELL` to enter boxstarter shell and execute the following:

```BOXSTARTERSHELL
Install-BoxstarterPackage -PackageName https://raw.githubusercontent.com/upnt/dotfiles/main/setup/boxstarter.ps1
```

Finally, execute the following to import the settings on powershell:
```powershell
.\setup\rcinstaller.ps1
```

### Unix/Linux
Install requirements and import settings.
```bash
sudo apt update && sudo apt install curl unzip git
./setup/rcinstaller.sh
```

## docker
If you want to try this repository, you can use the following packages.
- [myvim-docker](https://github.com/upnt/dotfiles/pkgs/container/myvim-docker)
  - you can use vimrc
- [mynvim-docker](https://github.com/upnt/dotfiles/pkgs/container/mynvim-docker)
  - you can use neovim configs
