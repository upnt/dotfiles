Set-Alias vim nvim

function nvim {
    if ($args -ne $null)  {
        $linux_args = $args.Replace('\', '/')
    }
    $volume = (Convert-Path ./) + ':/root/workspace'
    docker run --rm -it -v $volume ghcr.io/upnt/mynvim-docker:latest nvim $linux_args
}

function dev-nvim {
    $name = "nvim-dev"
    if (docker container ls -q -a -f name="$name") {
        docker start -i $name
    } else {
        docker run -w /root/.config/nvim --name $name -it upnt/dotfiles-docker:nightly bash
    }
}
