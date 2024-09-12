# Required:
# lsd: beautiful ls command from cargo
# bat: beautiful cat command from cargo
# fd: fast find command from cargo
# rg: fast grep command from cargo
# git: file manager from winget
# fzf: fuzzy finder from winget
# busybox64u: unicode linux commands on x64 from binary
#
# Recommended:
# git-delta: beautiful git diff from cargo
#

. "$PSScriptRoot\utils.ps1"

function prompt {
    $path = (Get-Location).ToString().Replace((Convert-Path ~), "~").Replace('\', '/')
    if (gcm git -ea SilentlyContinue) {
    	$branch = (git branch --show-current)
    } else {
	$branch = $null
    }
    $conda  = $env:CONDA_PROMPT_MODIFIER
    $venv  = $env:VIRTUAL_ENV

    ## first line
    Write-Host ""

    ## second line
    Write-Host "$env:USERNAME" -ForeGroundColor Yellow -NoNewLine

    Write-Host " $path" -ForeGroundColor Cyan -NoNewLine

    

    if ($branch -ne $null -and $host.UI.RawUI.WindowSize.Width -gt 70) {
        Write-Host " on " -ForeGroundColor White -NoNewLine
        Write-Host "`u{e725} $branch " -ForeGroundColor Red -NoNewLine
    }
    Write-Host ""
    if (($conda -ne $null) -And ($venv -eq $null)) {
    	Write-Host ($conda.SubString(1, $conda.Length - 3)) -ForeGroundColor Magenta -NoNewLine
    }
    Write-Host "" -ForeGroundColor White -NoNewLine

    return "`u{232A}"
}

if (gcm busybox -ea SilentlyContinue) {
	. "$PSScriptRoot\remove_aliases_for_busybox.ps1"
}
if ( "$(Get-Command lsd -ErrorAction SilentlyContinue)" -ne "" ) {
	Set-Alias ls lsd
	function ll {
	    ls --long $args
	}
	
	function la {
	    ls --all $args
	}
}
if ( "$(Get-Command bat -ErrorAction SilentlyContinue)" -ne "" ) {
	Set-Alias cat bat
}
if ( "$(Get-Command rg -ErrorAction SilentlyContinue)" -ne "" ) {
	Set-Alias grep rg
}
if ( "$(Get-Command fd -ErrorAction SilentlyContinue)" -ne "" ) {
	Set-Alias find fd
}

Set-PSReadLineKeyHandler -Key 'Ctrl+j' -Function HistorySearchForward
Set-PSReadLineKeyHandler -Key 'Ctrl+k' -Function HistorySearchBackward

Set-PSReadLineOption -PredictionSource History -PredictionViewStyle ListView
Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete
