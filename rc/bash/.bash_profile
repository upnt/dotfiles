# Load anyenv automatically by adding
# the following to ~/.bash_profile:

if [[ -d ~/.anyenv ]]; then
    export PATH="$HOME/.anyenv/bin:$PATH"
    eval "$(anyenv init -)"
fi

if [[ -f ~/.bashrc ]]; then
    . ~/.bashrc
fi

if [[ -d ~/.cargo ]]; then
    . "$HOME/.cargo/env"
fi
