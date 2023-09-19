# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
  test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
  alias ls='ls --color=auto'
  alias dir='dir --color=auto'
  alias vdir='vdir --color=auto'

  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
fi

alias cat=bat.exe
alias grep=rg.exe
alias find=fd.exe
alias ls='lsd'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

alias pd='pushd 1>/dev/null'
alias pop='popd 1>/dev/null'

if [ -x /usr/bin/fzf ]; then
    function fd {
        local dir=`find . -t d -p --color=always | 
            sed -e 's#\\\\#/#g' |
            fzf --ansi --reverse --preview 'lsd -l --color=always {}' --preview-window=up:60%`
        if [ -n "$dir" ]; then
            echo $dir
            pd $dir
        fi
    }
    
    function fe {
        local file=`find . -t f -p --color=always | 
            sed -e 's#\\\\#/#g' |
            fzf --ansi --reverse --preview 'bat --color=always {}' --preview-window=up:60%`
        if [ -n "$file" ]; then
            vim $file
        fi
    }
    
    function fdiff {
        local file=`find . -t f -p --color=always | 
            sed -e 's#\\\\#/#g' |
            fzf --ansi --reverse --preview "git diff $@ {}" --preview-window=up:60%`
        if [ -n "$file" ]; then
            git diff $@ $file
        fi
    }
    
    function gclone {
        local repo=`gh repo list -L 1000 | fzf --ansi --reverse | cut -f 1`
        gh repo clone $repo
    }
fi

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
