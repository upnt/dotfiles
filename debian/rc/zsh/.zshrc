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
    local red=$'\e[31m' green=$'\e[32m' yellow=$'\e[33m'
    local blue=$'\e[34m' magenta=$'\e[35m'
    local cyan=$'\e[36m' reset=$'\e[m'
    local branch_icon=$'\ue725'
    local branch="$(git branch --show-current 2> /dev/null)"
    PROMPT=$'\n'
    if [ -n "$VIRTUAL_ENV_PROMPT" ]; then
        PROMPT+="%B%{${green}%}${VIRTUAL_ENV_PROMPT}%{${reset}%}%b"$'\n'
    fi
    PROMPT+="%B%{${cyan}%}%~%{${reset}%}%b"
    if [ -n "$branch" ]; then
        PROMPT+=" on %B%{${red}%}${branch_icon} ${branch}%{${reset}%}%b"
    fi
    PROMPT+=$'\n'"%B"$'\u232A'"%b"
}

autoload -Uz add-zsh-hook
add-zsh-hook precmd prompt_precmd

export PATH="/opt/nvim-linux64/bin:$PATH"
if [[ -d ~/.anyenv ]]; then
    export PATH="$HOME/.anyenv/bin:$PATH"
    eval "$(anyenv init -)"
fi

if [[ -d ~/.cargo ]]; then
    . "$HOME/.cargo/env"
fi

if [[ -d ~/.llvm-project ]] then
    export PATH="${PATH}:${HOME}/.llvm-project/build/bin"
fi

if [[ -d /opt/gurobi1100 ]] then
    export GUROBI_HOME="/opt/gurobi1100/linux64"
    export PATH="${PATH}:${GUROBI_HOME}/bin"
    export LD_LIBRARY_PATH="${LD_LIBRARY_PATH}:${GUROBI_HOME}/lib"
fi


if [[ -d /usr/local/texlive/2023 ]]; then
    export PATH=$PATH:/usr/local/texlive/2023/bin/x86_64-linux
    export MANPATH=$MANPATH:/usr/local/texlive/2023/texmf-dist/doc/man
    export INFOPATH=$INFOPATH:/usr/local/texlive/2023/texmf-dist/doc/info
fi

if [[ -d /usr/local/texlive/2024 ]]; then
    export PATH=$PATH:/usr/local/texlive/2024/bin/x86_64-linux
    export MANPATH=$MANPATH:/usr/local/texlive/2024/texmf-dist/doc/man
    export INFOPATH=$INFOPATH:/usr/local/texlive/2024/texmf-dist/doc/info
fi

export PATH=$PATH:~/.local/bin

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias lt='ls --tree'
    alias rls='ls --color=auto | shuf | head -n 1'
    alias rcd='cd $(ls --color=never | shuf | head -n 1)'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# cargo install bat
if type "bat" > /dev/null 2>&1; then
    alias cat='bat'
fi
# cargo install ripgrep
if type "rg" > /dev/null 2>&1; then
    alias grep='rg'
fi
# cargo install fd-find
if type "fd" > /dev/null 2>&1; then
    alias find='fd'
fi
# cargo install lsd
if type "lsd" > /dev/null 2>&1; then
    alias ls='lsd -l --blocks "git,user,group,name"'
    alias la='ls -A'
    alias ll='lsd -alF'
else
    alias ll='ls -alF'
    alias la='ls -A'
fi



alias pd='pushd 1>/dev/null'
alias pop='popd 1>/dev/null'

# sudo apt install fzf
if type "fzf" > /dev/null 2>&1; then
    function ff {
        local dir
        # dir+=$'\e[34m'"./"$'\e[0m'$'\n'
        dir+=$'\e[34m'"../"$'\e[0m'$'\n'
        dir+=`fd . --hidden -t d -p --color=always --maxdepth=1 | sed -e 's#\\\\#/#g'`
        dir=`echo -n $dir | fzf --ansi --reverse --preview 'lsd -l --color=always {}' --preview-window=up:60%`
        if [ -n "$dir" ]; then
            pd $dir
            if [ "$dir" != "./" ] && [ ! -d ".git" ]; then
                ff
            fi
        fi
    }

    function fe {
        local file=`find . -t f -p --hidden --exclude=".git/" --color=always |
        sed -e 's#\\\\#/#g' |
        fzf --ansi --reverse --preview 'bat --color=always {}' --preview-window=up:60%`
        if [ -n "$file" ]; then
            vim $file
        fi
    }

    function fdiff {
        local file=`find . -t f -p --hidden --color=always --exclude=".git/" |
        sed -e 's#\\\\#/#g' |
        fzf --ansi --reverse --preview "git diff $@ {}" --preview-window=up:60%`
        if [ -n "$file" ]; then
            git diff $@ $file
        fi
    }

    function get_repos {
        local repo=`gh repo list $1 --json "nameWithOwner" | jq -r '.[]["nameWithOwner"]'`
        echo $repo
    }

    function gclone {
        local repos=`get_repos`
        if [ "$1" = "-a" ] || [ "$1" = "--all" ]; then
            for i in `gh org list`
            do
                local buf=`get_repos $i`
                if [ ! "$buf" = "" ]; then
                    repos="${repos}\n${buf}"
                fi
            done
        fi
        local repo=`echo $repos | fzf --ansi --reverse | cut -f 1`
        if [ ! "$repo" = "" ]; then
            gh repo clone "$repo" $@
        fi
    }
fi

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

export LESS='-R'

fpath+=~/.zsh_functions
autoload -Uz compinit && compinit
