# Load anyenv automatically by adding
# the following to ~/.bash_profile:

export PATH="$HOME/.anyenv/bin:$PATH"
eval "$(anyenv init -)"

if [[ -f ~/.bashrc ]]; then
    . ~/.bashrc
fi
. "$HOME/.cargo/env"
