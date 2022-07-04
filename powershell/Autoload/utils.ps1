Remove-Alias ls

function ls {
    lsd $args
}

function ll {
    lsd -l $args
}

function la {
    lsd -a $args
}

function path_to_linux ($path) {
    $fullpath = (Convert-Path $path)
    $drive = $fullpath.Substring(0, 1).ToLower()
    return '/' + $drive + '/' + (Convert-Path $path).Substring(3).Replace('\', '/')
}
