function fd {
    Get-ChildItem . -Recurse -Attributes Directory | Invoke-Fzf | Set-Location
}

function fr {
    Get-ChildItem ~ -Recurse -Attributes Directory | Invoke-Fzf | Set-Location
}

function fe {
    Get-ChildItem . -Recurse -Attributes !Directory | Invoke-Fzf | nvim
}

