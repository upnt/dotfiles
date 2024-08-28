# dotfiles
## Ubuntu or wsl
```bash
cd ~/.local
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply upnt
```

## Powershell on Windows
```powershell
iex "&{$(irm 'https://get.chezmoi.io/ps1')} -b '~/.local/bin'"
          $ENV:Path="~/.local/bin;"+$ENV:Path
          chezmoi init https://github.com/$GITHUB_USERNAME/dotfiles.git
          chezmoi apply -v
```
