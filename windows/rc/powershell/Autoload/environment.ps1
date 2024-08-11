# python
function python  {
    $container = 'pipenv'
    $volume = (Convert-Path ~) + ':/root/mnt'
    $workdir = '/root/mnt' + (Convert-Path .).Replace((Convert-Path ~), '').Replace('\', '/')
    $linux_args = args_to_linux($args)
    if (docker container ls -q -a -f name=$container) {
        docker start $container 1>$null
        docker exec -w $workdir $container python $linux_args
        docker stop $container 1>$null
    } else {
        docker run --name $container -v $volume -itd ghcr.io/upnt/pipenv:latest bash 1>$null
        docker exec -w $workdir $container python $linux_args
        docker stop $container 1>$null
    }
}

function python-shell {
    $volume = (Convert-Path ~) + ':/root/mnt'
    $workdir = '/root/mnt' + (Convert-Path .).Replace((Convert-Path ~), '').Replace('\', '/')
    docker run --rm -it -w $workdir -v $volume python:slim-buster bash
}

function pipenv {
    $container = "pipenv"
    $volume = (Convert-Path ~) + ':/root/mnt'
    $workdir = '/root/mnt' + (Convert-Path .).Replace((Convert-Path ~), '').Replace('\', '/')
    $linux_args = args_to_linux($args)
    if (docker container ls -q -a -f name=$container) {
        docker start $container 1>$null
        docker exec -w $workdir $container pipenv $linux_args
        docker stop $container 1>$null
    } else {
        docker run --name $container -v $volume -itd ghcr.io/upnt/pipenv:latest bash 1>$null
        docker exec -w $workdir $container pipenv $linux_args
        docker stop $container 1>$null
    }
}
