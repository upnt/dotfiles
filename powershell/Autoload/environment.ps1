# python
function python  {
    $volume = (Convert-Path ./) + ':/root/workspace'
    $linux_name = $args.Replace('\', '/')
    docker run --rm -it -v $volume python:slim-buster python $filename
}

function python-shell {
    $volume = (Convert-Path ./) + ':/root/workspace'
    docker run --rm -it -w /root/workspace -v $volume python:slim-buster bash
}

function pipenv-shell {
    $volume = (Convert-Path ./) + ':/root/workspace'
    $name = "nvim-dev"
    if (docker container ls -q -a -f name="$name") {
        docker start -i $name
    } else {
        docker run -v $volume --name $name -it upnt/pipenv:latest bash
    }
}

