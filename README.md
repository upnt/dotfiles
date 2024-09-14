# dotfiles

[![Windows PowerShell](https://github.com/upnt/dotfiles/actions/workflows/windows-installation.yml/badge.svg)](https://github.com/upnt/dotfiles/actions/workflows/windows-installation.yml)
[![Ubuntu](https://github.com/upnt/dotfiles/actions/workflows/ubuntu-installation.yml/badge.svg)](https://github.com/upnt/dotfiles/actions/workflows/ubuntu-installation.yml)

dotfiles managed by chezmoi

## Linux
### support
- debian only
### install
```bash
mkdir -p ~/.local
cd ~/.local
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply upnt
```

## Windows PowersShell
### install
```powershell
iex "&{$(irm 'https://get.chezmoi.io/ps1')} -b '~/.local/bin'"
~/.local/bin/chezmoi init --apply upnt
```
