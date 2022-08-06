# config
export LANG=ja_JP.UTF-8
export TERM="xterm-256color"
export DENO_INSTALL="/$HOME/.deno"
export PATH="$PATH:$DENO_INSTALL/bin"

if [ -d /home/linuxbrew ]; then
    export LDFLAGS="-L/home/linuxbrew/.linuxbrew/opt/llvm/lib -Wl,-rpath,/home/linuxbrew/.linuxbrew/opt/llvm/lib"
    export PATH="/home/linuxbrew/.linuxbrew/bin:$PATH"
    export PATH="/home/linuxbrew/.linuxbrew/sbin:$PATH"
fi

if [ -d $HOME/.pyenv ]; then
    export PYENV_ROOT="$HOME/.pyenv"
    export PATH="$PYENV_ROOT/bin:$PATH"
    export PYENV_VIRTUALENV_DISABLE_PROMPT=1
    eval "$(pyenv init -)"
fi

if [ -d $HOME/.pyenv/plugins/pyenv-virtualenv ]; then
    eval "$(pyenv virtualenv-init -)"
fi
if [ -d $HOME/warkspace/go ]; then
    export GOPATH="$HOME/workspace/go"
    export PATH="$GOPATH/bin:$PATH"
fi



# env
[ -x /home/linuxbrew/.linuxbrew/bin/pyenv ] && eval "$(pyenv init -)"
[ -x $HOME/.pyenv/shims/virtualenv ] && eval "$(pyenv virtualenv-init -)"
[ -x /home/linuxbrew/.linuxbrew/bin/rbenv ] && eval "$(rbenv init -)"
[ -x /home/linuxbrew/.linuxbrew/bin/nodenv ] && eval "$(nodenv init -)"
# starship
[ -x /home/linuxbrew/.linuxbrew/bin/starship ] && eval "$(starship init bash)"

# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
# case $- in
#     *i*) ;;
#       *) return;;
# esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

force_color_prompt=yes
PS1='\n${debian_chroot:+($debian_chroot)}\[\e[01;33m\]\u@\h \[\e[01;36m\]\w\[\e[01;37m\]\n> '

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi
