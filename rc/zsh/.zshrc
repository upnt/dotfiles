# Set up the prompt

autoload -Uz promptinit
promptinit
prompt adam1

setopt histignorealldups sharehistory

# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

# Use modern completion system
autoload -Uz compinit
compinit

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

prompt_precmd() {
    local magenta=$'\e[35m' cyan=$'\e[36m' reset=$'\e[m'
    local branch_icon=$'\ue725'
    local branch="$(git branch --show-current 2> /dev/null)"
    PROMPT=$'\n'"%B%{${cyan}%}%~%{${reset}%}%b"
    if [ -n "$branch" ]; then
        PROMPT+=" on %B%{${magenta}%}${branch_icon} ${branch}%{${reset}%}%b"
    fi
    PROMPT+=$'\n'"%B"$'\u232A'"%b"
}

autoload -Uz add-zsh-hook
add-zsh-hook precmd prompt_precmd

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# Load anyenv automatically by adding
# the following to ~/.bash_profile:

if [[ -d ~/.anyenv ]]; then
    export PATH="$HOME/.anyenv/bin:$PATH"
    eval "$(anyenv init -)"
fi

if [[ -d ~/.cargo ]]; then
    . "$HOME/.cargo/env"
fi
