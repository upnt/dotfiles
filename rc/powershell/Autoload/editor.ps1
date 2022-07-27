Set-Alias vim nvim

function nvim {
    $cache = (Convert-Path ~) + '\.cache\undo:/root/.cache/undo'
    $volume = (Convert-Path ~) + ':/root/mnt'
    $workdir = '/root/mnt' + (Convert-Path .).Replace((Convert-Path ~), '').Replace('\', '/')
    if ($args -ne $null)  {
        $linux_args = $args.Replace('\', '/')
    }
    docker run --rm -w $workdir -it -v $volume -v $cache ghcr.io/upnt/mynvim-docker:latest nvim $linux_args
}

function dev-nvim {
    $name = "nvim-dev"
    if (docker container ls -q -a -f name="$name") {
        docker start -i $name
    } else {
        docker run -w /root/.config/nvim --name $name -it upnt/dotfiles-docker:nightly bash
    }
}
