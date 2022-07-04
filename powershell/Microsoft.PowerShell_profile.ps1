# Recommaneded:
# - lsd: beautiful ls command
# - busybox: some linux commands

Set-PSReadLineKeyHandler -Key 'Ctrl+n' -Function HistorySearchForward
Set-PSReadLineKeyHandler -Key 'Ctrl+p' -Function HistorySearchBackward

Set-PSReadLineOption -PredictionSource History -PredictionViewStyle ListView
Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete

function prompt {
    $path = (Get-Location).ToString().Replace((Convert-Path ~), "~")
    $branch = (git branch --show-current)

    ## first line
    Write-Host ""

    ## second line
    Write-Host "`u{256d}`u{2500}`u{2500}`u{E0B6}" -ForeGroundColor Blue -nonewline 
    Write-Host " $env:USERNAME " -ForeGroundColor White -BackGroundColor Blue -NoNewLine
    Write-Host "`u{E0B0}" -ForeGroundColor Blue -BackGroundColor DarkGray -nonewline

    Write-Host " $path " -BackGroundColor DarkGray -NoNewLine

    if ($branch -ne $null) {
        Write-Host "`u{E0B0}" -ForeGroundColor DarkGray -BackGroundColor DarkGreen -nonewline

        Write-Host " `u{2E19} $branch " -ForeGroundColor Black -BackGroundColor DarkGreen -NoNewLine
        Write-Host "`u{E0B0}" -ForeGroundColor DarkGreen -nonewline
    } else {
        Write-Host "`u{E0B0}" -ForeGroundColor DarkGray -nonewline
    }

    Write-Host ""

    # third line
    Write-Host "`u{2570}`u{2500}" -ForeGroundColor Cyan -nonewline 
    Write-Host "`u{232A}" -ForeGroundColor White -nonewline 

    return " "
}



$AutoloadDir = (Get-Item $PROFILE).DirectoryName + "\Autoload"
Get-ChildItem $AutoloadDir | where Extension -eq ".ps1" | %{.$_.FullName}
