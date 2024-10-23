$_HAS_GIT = Get-Command git -ea SilentlyContinue

function prompt {
    $path = (Get-Location).ToString().Replace((Convert-Path ~), "~")
    $branch = if ($_HAS_GIT) { git branch --show-current } else { $null }

    ## first line
    Write-Host ""

    ## second line
    Write-Host "$env:USERNAME" -ForeGroundColor Yellow -NoNewLine
    Write-Host " $path" -ForeGroundColor Cyan -NoNewLine

    if ($branch -and $host.UI.RawUI.WindowSize.Width -gt 70) {
        Write-Host " on " -ForeGroundColor White -NoNewLine
        Write-Host "`u{e725} $branch " -ForeGroundColor Red -NoNewLine
    }
    Write-Host ""
    if (($env:CONDA_PROMPT_MODIFIER -ne $null) -And ($env:VIRTUAL_ENV -eq $null)) {
    	Write-Host (
            $env:CONDA_PROMPT_MODIFIER.SubString(1, $env:CONDA_PROMPT_MODIFIER.Length - 3)
        ) -ForeGroundColor Magenta -NoNewLine
    }
    Write-Host "" -ForeGroundColor White -NoNewLine

    return "`u{232A}"
}

if ( "$(Get-Command lsd -ErrorAction SilentlyContinue)" -ne "" ) {
	Set-Alias ls lsd
	function ll { ls --long $args }
	function la { ls --all $args }
}
	
if ( "$(Get-Command bat -ErrorAction SilentlyContinue)" -ne "" ) { Set-Alias cat bat }
if ( "$(Get-Command rg -ErrorAction SilentlyContinue)" -ne "" ) { Set-Alias grep rg }
if ( "$(Get-Command fd -ErrorAction SilentlyContinue)" -ne "" ) { Set-Alias find fd }

if ( "$(Get-Command zoxide -ErrorAction SilentlyContinue)" -ne "" ) {
	Invoke-Expression (& { (zoxide init powershell | Out-String) })
	Remove-Alias cd -ErrorAction Ignore
	Set-Alias cd z
}

Set-PSReadLineKeyHandler -Key 'Ctrl+j' -Function HistorySearchForward
Set-PSReadLineKeyHandler -Key 'Ctrl+k' -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete

. $PSScriptRoot/chezmoi.ps1
