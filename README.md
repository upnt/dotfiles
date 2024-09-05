# dotfiles
dotfiles managed by chezmoi
[![Windows PowerShell](https://github.com/upnt/dotfiles/actions/workflows/chezmoi.yml/badge.svg)](https://github.com/upnt/dotfiles/actions/workflows/powershell-installation.yml)
[![Ubuntu](https://github.com/upnt/dotfiles/actions/workflows/chezmoi.yml/badge.svg)](https://github.com/upnt/dotfiles/actions/workflows/ubuntu-installation.yml)

## Linux
### support
- Ubuntu
- wsl
### install
```bash
mkdir -p ~/.local
cd ~/.local
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply upnt
```

## Windows
### support
- Powershell
### install
```powershell
iex "&{$(irm 'https://get.chezmoi.io/ps1')} -b '~/.local/bin'"
~/.local/bin/chezmoi init --apply upnt
```
