Set-Alias vim nvim

function nvim {
    $container = 'nvim'
    $volume = (Convert-Path ~) + ':/root/mnt'
    $workdir = '/root/mnt' + (Convert-Path .).Replace((Convert-Path ~), '').Replace('\', '/')
    $linux_args = args_to_linux($args)
    if (docker ps -a --filter "name=nvim" --format "{{.ID}}") {
        docker start $container 1>$null
    } else {
        docker run --name $container -v $volume -itd ghcr.io/upnt/mynvim-docker:latest bash 1>$null
    }

    docker exec -it -w $workdir $container nvim $linux_args

    # docker stop $container 1>$null
}

function dev-nvim {
    $name = "dev-nvim"
    if (docker container ls -q -a -f name="$name") {
        docker start -i $name
    } else {
        docker run -w /root/.config/nvim --name $name -it ghcr.io/upnt/mynvim-docker:nightly bash
    }
}
