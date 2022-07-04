# Recommaneded:
# - lsd: beautiful ls command
# - busybox: some linux commands

Set-PSReadLineKeyHandler -Key 'Ctrl+n' -Function HistorySearchForward
Set-PSReadLineKeyHandler -Key 'Ctrl+p' -Function HistorySearchBackward

Set-PSReadLineOption -PredictionSource History -PredictionViewStyle ListView
Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete

function prompt {
    $line = ""
    Write-Host $line

    $path = Get-Location
    $line = "`u{256d}" + "`u{2500}`u{2500}" + " " + $path
    Write-Host $line

    return "`u{2570}" + "`u{2500}" + "`u{232A}"
}


$AutoloadDir = (Get-Item $PROFILE).DirectoryName + "\Autoload"
Get-ChildItem $AutoloadDir | where Extension -eq ".ps1" | %{.$_.FullName}
