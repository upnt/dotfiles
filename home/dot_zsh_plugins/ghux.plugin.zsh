#!/usr/bin/env zsh
#
# if you want to going dotfiles dir with ghux, add this option
# GHUX_DOTFILES_OPTION=1
: ${GHUX_DOTFILES_OPTION:=0}

# set ghux aliases path
: ${GHUX_ALIASES_PATH:="$HOME/.ghux_aliases"}


function print_usage() {
    /usr/bin/cat << EOL
You dont have ghq or fzf.
$ go get github.com/motemen/ghq
$ brew install fzf
EOL
}

function ghux() {
    if ! (type fzf &> /dev/null); then
        print_usage
        exit 1
    fi

    # touchはファイルが存在しなかったときだけ作ってくれるので
    /usr/bin/touch $GHUX_ALIASES_PATH
    local file
    file="$GHUX_ALIASES_PATH"
    local project_alias 
    local project_name  
    local project_dir
    if [[ -n $1 ]] && [[ `/usr/bin/cat $file |/usr/bin/grep -E "$1"` ]];then
        local tmp=$(/usr/bin/cat $file |/usr/bin/grep "$1")
        line=( `echo $tmp | /usr/bin/tr -s ',' ' '` )
        project_alias=${line[1]}
        project_name=${line[2]}
        project_dir=${line[3]}
    else
        project_list="$(/usr/bin/cat $file | /usr/bin/awk -F , '{print "[alias]", $1}')"
        if ( type ghq &> /dev/null ); then
            ghq_list=$(ghq list)
            project_list="$ghq_list\n$project_list"
        fi
        if ( type gclone &> /dev/null ); then
            gh_list="[github] clone from github"
            project_list="$project_list\n$gh_list"
        fi
        repo_list="[create] new repository"
        project_list="$project_list\n$repo_list"
        local list


        project_dir=$(echo $project_list|fzf)

        if [[ -z $project_dir ]]; then
            [[ -n $CURSOR ]] && zle redisplay
            return 1
        fi

        if (echo $project_dir | /usr/bin/grep -E "^\[alias\]" &>/dev/null);then
            local als=$(echo $project_dir| /usr/bin/awk '{print $2}')
            line=( `/usr/bin/cat $file|/usr/bin/grep -E "^$als" | /usr/bin/tr -s ',' ' '` )
            project_alias=${line[1]}
            project_name=$(echo ${line[2]}| /usr/bin/awk '{sub("\\.",""); print $0}')
            project_dir=${line[3]}
        elif (echo $project_dir | /usr/bin/grep -E "^\[github\]" &>/dev/null);then
            cd $(ghq root); project_name=$(gclone); cd -
            project_name=${project_name##*/}
            project_dir=$(ghq root)/$project_name
        elif (echo $project_dir | /usr/bin/grep -E "^\[create\]" &>/dev/null);then
            read project_name"?project name: "
            project_dir=$(ghq root)/$project_name
            if [ ! -d "$project_dir" ]; then
                mkdir $project_dir
                cd $project_dir; git init; cd -
            else;
                echo "${project_dir} already exists"
            fi
        else
            project_dir=$(ghq root)/$project_dir
            project_name=$(echo $project_dir | /usr/bin/rev | /usr/bin/awk -F \/ '{printf "%s", $1}' | /usr/bin/rev | /usr/bin/awk '{sub("\\.",""); print $0}')
        fi
    fi

    # if you in tmux sesion
    local in_tmux
    [[ -n $TMUX ]] && in_tmux=0 || in_tmux=1

    local tmux_list=$(tmux list-session 2>/dev/null)

    # tmuxに既にfzfで選択したプロジェクトのセッションが存在するかどうか
    if  ! (echo $tmux_list | /usr/bin/grep -E "^$project_name" &>/dev/null); then
        (cd $(eval echo ${project_dir}) && TMUX=; tmux new-session -ds $project_name 2>/dev/null) > /dev/null # cdした後lsしちゃうので
    fi


    if [[ $in_tmux == 0 ]] ; then
        if [[ -n "$CONTEXT" ]]; then
            BUFFER="tmux switch-client -t $project_name"&& zle accept-line && zle redisplay
        elif [[ -n "$project_name" ]]; then
            tmux switch-client -t $project_name
        fi
    else;
        
        if [[ -n "$CONTEXT" ]]; then
            BUFFER="tmux attach-session -t $project_name"&& zle accept-line && zle redisplay
        elif [[ -n "$project_name" ]]; then
            tmux attach-session -t $project_name
        fi
    fi
}

zle -N ghux
