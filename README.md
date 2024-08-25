# dotfiles
This repository has below settings and makes it easy to set up windows and linux.

## debian
### configs
- git
- latexmk
- anyenv
- neovim (editor)
- zathura (pdf viewer)
- zsh (terminal)
- alacritty (terminal emulator)

### installations
All features are provided by Makefile
```bash
git clone https://github.com/upnt/dotfiles.git
cd dotfiles/debian
make
make install
```
After installation, restart the shell.

Installation for envs (pyenv, rbenv, etc.)
```bash
make install-envs
```
After installation, restart the shell.

Installation for packages (python 3.10, ruby 3.3.4, etc.)
```bash
make install-packages
```

