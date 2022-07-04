# Recommaneded:
# - lsd: beautiful ls command
# - busybox: some linux commands

Set-PSReadLineKeyHandler -Key 'Ctrl+n' -Function HistorySearchForward
Set-PSReadLineKeyHandler -Key 'Ctrl+p' -Function HistorySearchBackward

Set-PSReadLineOption -PredictionSource History -PredictionViewStyle ListView
Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete

function prompt {
    ## first line
    Write-Host ""

    ## second line
    $path = (Get-Location).ToString().Replace((Convert-Path ~), "~")
    Write-Host "`u{256d}" -foregroundcolor Blue -nonewline 
    Write-Host "`u{2500}`u{2500}" -foregroundcolor Blue -nonewline 
    Write-Host "`u{E0B6}" -foregroundcolor Blue -nonewline 

    Write-Host " " -backgroundcolor Blue -nonewline
    Write-Host $env:USERNAME -backgroundcolor Blue -nonewline
    Write-Host " " -backgroundcolor Blue -nonewline
    Write-Host "`u{E0B0}" -foregroundcolor Blue -backgroundcolor DarkGray -nonewline

    Write-Host " " -backgroundcolor DarkGray -nonewline
    Write-Host $path -backgroundcolor DarkGray -nonewline
    Write-Host " " -backgroundcolor DarkGray -nonewline
    Write-Host "`u{E0B0}" -foregroundcolor DarkGray -nonewline

    Write-Host ""

    # third line
    Write-Host "`u{2570}" -foregroundcolor Cyan -nonewline 
    Write-Host "`u{2500}" -foregroundcolor Cyan -nonewline 
    Write-Host "`u{232A}" -foregroundcolor White -nonewline 

    return " "
}



$AutoloadDir = (Get-Item $PROFILE).DirectoryName + "\Autoload"
Get-ChildItem $AutoloadDir | where Extension -eq ".ps1" | %{.$_.FullName}
