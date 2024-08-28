# dotfiles
## Linux
### support
- Ubuntu
- wsl
### install
```bash
cd ~/.local
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply upnt
```

## Windows
### support
- Powershell
### install
```powershell
iex "&{$(irm 'https://get.chezmoi.io/ps1')} -b '~/.local/bin'"
~/.local/bin/chezmoi init https://github.com/upnt/dotfiles.git
~/.local/bin/chezmoi apply -v
```
