$_HAS = @{}

foreach ($cmd in 'git', 'lsd', 'bat', 'rg', 'fd', 'zoxide')
{
    $_HAS.add($cmd, (Test-Path $HOME\AppData\Local\Microsoft\WinGet\Links\$cmd.exe))
}

function prompt
{
    $path = (Get-Location).ToString().Replace($HOME, "~")
    $branch = if ($_HAS['git'])
    {
        git branch --show-current 
    } else
    {
        $null 
    }

    ## first line
    Write-Host ""

    ## second line
    Write-Host "$env:USERNAME" -ForeGroundColor Yellow -NoNewLine
    Write-Host " $path" -ForeGroundColor Cyan -NoNewLine

    if ($branch -and $host.UI.RawUI.WindowSize.Width -gt 70)
    {
        Write-Host " on " -ForeGroundColor White -NoNewLine
        Write-Host "`u{e725} $branch " -ForeGroundColor Red -NoNewLine
    }
    Write-Host ""
    if (($null -ne $env:CONDA_PROMPT_MODIFIER) -And ($null -eq $env:VIRTUAL_ENV))
    {
        Write-Host (
            $env:CONDA_PROMPT_MODIFIER.SubString(1, $env:CONDA_PROMPT_MODIFIER.Length - 3)
        ) -ForeGroundColor Magenta -NoNewLine
    }
    Write-Host "" -ForeGroundColor White -NoNewLine

    return "`u{232A}"
}

if ( $_HAS['rg'] )
{
    Set-Alias grep rg 
}
if ( $_HAS['bat'] )
{
    Set-Alias cat bat 
}
if ( $_HAS['fd'] )
{
    Set-Alias find fd 
}

if ( $_HAS['lsd'] )
{
    $null = Set-Alias ls lsd
    function ll
    { ls --long $args 
    }
    function lt
    { ls --tree $args 
    }
    function la
    { ls --all $args 
    }
}

function gclone
{
    param (
        [string]$option = "",
        [string[]]$extraArgs = @()
    )

    $repos = (gh repo list --json "nameWithOwner" | jq -r '.[]["nameWithOwner"]')
    if ( ( $option -eq "-a" ) -or ( $option -eq "--all" ) )
    {
        foreach ($i in (gh org list) )
        {
            $buf = (gh repo list $i --json "nameWithOwner" | jq -r '.[]["nameWithOwner"]')
            if ( -not ($buf -eq "") )
            {
                $repos = "$repos\n$buf"
            }
        }
    }
    $repo = (Write-Host $repos | fzf --ansi --reverse | cut -f 1)
    if ( -not ($repo -eq "" ) )
    {
        gh repo clone $repo $extraArgs
    }
    Write-Host $repo
}

Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete
Set-PSReadLineKeyHandler -Key 'Ctrl+j' -Function HistorySearchForward
Set-PSReadLineKeyHandler -Key 'Ctrl+k' -Function HistorySearchBackward

. $PSScriptRoot/chezmoi.ps1
