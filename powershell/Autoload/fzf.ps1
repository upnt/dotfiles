function fd {
    Get-ChildItem . -Recurse -Attributes Directory | Invoke-Fzf | Set-Location
}

function fr {
    $dirs = @((Get-Item ~/workspace), (Get-Item ~/OneDrive), (Get-Item ~/Documents))
    $dirs = $dirs | ForEach-Object {Get-ChildItem -Recurse $_ -Attributes Directory}
    $dirs = (Get-ChildItem ~ -Attributes Directory) + $dirs
    $dirs | Invoke-Fzf | Set-Location
}

function fe {
    $filepath = (Get-ChildItem . -Recurse -Attributes !Directory | Invoke-Fzf)
    nvim (Resolve-Path $filepath -Relative)
}

function fre {
    $dirs = @((Get-Item ~/workspace), (Get-Item ~/OneDrive), (Get-Item ~/Documents))
    $filepath = ($dirs | ForEach-Object {Get-ChildItem -Recurse $_ -Attributes !Directory} | Invoke-Fzf)
    nvim (Resolve-Path $filepath -Relative)
}

function fbr {
    $branches = (git branch)
    if ($branches -eq $null) {
        return
    }
    $branch = ($branches | Invoke-Fzf).Substring(2)
    git switch $branch
}

function fbrm {
    $branches = (git branch --all)
    if ($branches -eq $null) {
        return
    }
    $branch = ($branches | Select-String "HEAD" -NotMatch | Invoke-Fzf).Substring(2)
    git switch $branch
}

function fdiff {
    $filename = (Get-ChildItem . -Recurse -Attributes !Directory | Invoke-Fzf)
    git diff HEAD -- $filename
}
