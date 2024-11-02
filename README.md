# dotfiles

[![Windows PowerShell](https://github.com/upnt/dotfiles/actions/workflows/windows-installation.yml/badge.svg)](https://github.com/upnt/dotfiles/actions/workflows/windows-installation.yml)
[![Ubuntu](https://github.com/upnt/dotfiles/actions/workflows/ubuntu-installation.yml/badge.svg)](https://github.com/upnt/dotfiles/actions/workflows/ubuntu-installation.yml)

Dotfiles managed by chezmoi

## Support

- [x] Debian (including WSL)
- [x] Windows
- [ ] macOS

## Installation

### Windows PowerShell

```powershell
iex "&{$(irm 'https://get.chezmoi.io/ps1')} -b '~\.local\bin'"
~\.local\bin\chezmoi init --apply upnt
```

If you're a OneDrive user, simply add the following script to enhance your setup! Just drop it into `$HOME\OneDrive\Documents\PowerShell\Microsoft.PowerShell_profile.ps1`, and you're good to go!

```powershell:Microsoft.PowerShell_profile.ps1
. "$Home\AppData\Local\PowerShell\Microsoft.PowerShell_profile.ps1"
```

### Debian (including WSL)

```bash
mkdir -p ~/.local
cd ~/.local
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply upnt
```

## Features

### Windows PowerShell

- [x] Graphical, fast terminal
- [x] Git and GitHub cli support
- [x] Fast and minimal editor (Neovim minimal setting)
- [x] GUI applications for development

### Debian (including WSL)

- [x] Graphical, fast terminal
- [x] Git and GitHub cli support
- [x] Graphical, highly functional editor (Neovim using LSP)
- [x] Repository management on tmux using ghux
- [x] Some compilers installed by asdf
- [x] GUI applications for development
