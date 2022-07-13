function ls {
    lsd $args
}

function ll {
    lsd -l $args
}

function la {
    lsd -a $args
}

function fullpath_to_linux ($path) {
    $fullpath = (Convert-Path $path)
    $drive = $fullpath.Substring(0, 1).ToLower()
    return '/' + $drive + '/' + (Convert-Path $path).Substring(3).Replace('\', '/')
}

function args_to_linux {
    $result = @()
    if ($args.count -ne 0)  {
        foreach ($arg in $args) {
            $result += $arg.Replace('\', '/')
        }
    }
    return $result
}
