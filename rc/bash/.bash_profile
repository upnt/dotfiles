# Load anyenv automatically by adding
# the following to ~/.bash_profile:

if [[ -d $HOME/.anyenv ]]; then
    export PATH="$HOME/.anyenv/bin:$PATH"
    eval "$(anyenv init -)"
fi

if [[ -f $HOME/.bashrc ]]; then
    . "$HOME/.bashrc"
fi

if [[ -d $HOME/.cargo ]]; then
    . "$HOME/.cargo/env"
fi
