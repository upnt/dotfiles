$_HAS = @{}

foreach ($cmd in 'git', 'lsd', 'bat', 'rg', 'fd', 'zoxide')
{
    $_HAS.add($cmd, (Test-Path $HOME\AppData\Local\Microsoft\WinGet\Links\$cmd.exe))
}

if ( $_HAS['rg'] )
{
    Set-Alias grep rg 
}
if ( $_HAS['bat'] )
{
    Set-Alias -Name cat -Value bat -Option AllScope
}
if ( $_HAS['fd'] )
{
    Set-Alias find fd 
}

if ( $_HAS['lsd'] )
{
    $null = Set-Alias -Name ls -Value lsd -Option AllScope
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

    # $repo = (Write-Output $repos | fzf --ansi --reverse--preview='tree -d -L 3 (_ftm_parse (Write-Output {}).Substring(2)) | head -n 50')
    # $repo = (Write-Output $repos | fzf --ansi --reverse--preview='Write-Output {}')
    # $repo = (Write-Output $repos | fzf --ansi --reverse--preview='tree -d -L 3 $(_ftm_parse ${"$(echo {})":2} | cut -d"," -f2) | head -n 50')
    if ( -not ($repo -eq "" ) )
    {
        gh repo clone $repo $extraArgs
    }
}

function _ftm_parse ($Alias) {
    $projectName = ""
    $projectDir = ""

    # 入力が[alias]で始まる場合
    if ($Alias -match "^\[alias\]") {
        $projectName = $Alias.Substring(8)
        $line = Get-Content $env:GHUX_ALIASES_PATH | Select-String -Pattern "$projectName," | ForEach-Object {
            ($_ -split ',')[1]
        }
	if (-not $line) {
		return
	}
        $projectDir = $line.Replace("/", "\").Replace('$HOME', "$HOME")
    }
    # 入力が[.*]で始まる場合
    elseif ($Alias -match "^\[.*\]") {
        $projectDir = ghq root
        $projectName = "default"
    }
    # その他の場合
    else {
        $projectDir = Join-Path -Path (ghq root) -ChildPath $Alias
        $projectName = $projectDir -split '/' | Select-Object -Last 1
        $projectName = $projectName -replace '\.', ''
    }

    # 結果を出力
    return "$projectName,$projectDir"
}

function git-uploaded {
    if (git status -s) {
	Write-Output "There are uncommitted files"
    }

    if (git status | Select-String "ahead of") {
	Write-Output "There are unpushed files"
    }
}

function ftm
{
    $projectList = @()

    # GHUX_ALIASES_PATHの読み込み
    Get-Content $Env:GHUX_ALIASES_PATH | ForEach-Object {
	$projectStatus = ""
        $line = $_ -split ','
        $tmp = $line[0]
        $dir = $line[1]

	$dir = $dir.Replace("/", "\").Replace('$HOME', "$HOME") 

	if (Test-Path $dir) {
        	# ディレクトリ移動とチェック
        	Push-Location -Path $dir -ErrorAction SilentlyContinue
        	if (-not (Test-Path .git)) {
        	    $projectStatus = " "
		} elseif(git-uploaded)
        	{
        	    $projectStatus = "✓"
        	} else
        	{
        	    $projectStatus = " "
        	}
        	$projectList += "$projectStatus [alias] $tmp"
        	Pop-Location -ErrorAction SilentlyContinue
	}
    }

    # ghqリストの処理
    ghq list | Sort-Object -Descending | ForEach-Object {
	$projectStatus = ""
        $dir = Join-Path (ghq root) $_
        Push-Location -Path $dir -ErrorAction SilentlyContinue
        if (git-uploaded)
        {
            $projectStatus = "✓"
        } else
        {
            $projectStatus = " "
        }
        $projectList += "$projectStatus $_"
        Pop-Location -ErrorAction SilentlyContinue
    }

    # メニュー作成
    $projectList = @("  [create] new repository") + $projectList
    if (Get-Command gclone -ErrorAction SilentlyContinue)
    {
        $projectList = @("  [create] clone from github") + $projectList
    }

    # fzfでプロジェクト選択
    $alias = $projectList | fzf

    if (-not $alias) {
	return
    }

    $alias = $alias.Substring(2)

    # プロジェクト情報の処理
    if ($alias -match "^\[create\]")
    {
        if ($alias -match "github")
        {
            Push-Location -Path (ghq root)
            $projectName = gclone
            Pop-Location
	    if (-not $projectName) {
		    return
	    }
            $projectName = $projectName.Split('\')[-1]
            $projectDir = Join-Path (ghq root) $projectName
        } else
        {
            $projectName = Read-Host "Project name"
            $projectDir = Join-Path (ghq root) $projectName
            if (-not (Test-Path $projectDir))
            {
                New-Item -ItemType Directory -Path $projectDir | Out-Null
                Push-Location -Path $projectDir
                git init | Out-Null
                Pop-Location
            } else
            {
                Write-Output "$projectDir already exists"
            }
        }
    } else
    {
        $projectName, $projectDir = (_ftm_parse $alias) -split ","
    }

    if (-not $projectDir)
    {
        return
    }

    cd $projectDir

}

Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete
Set-PSReadLineKeyHandler -Key 'Ctrl+j' -Function HistorySearchForward
Set-PSReadLineKeyHandler -Key 'Ctrl+k' -Function HistorySearchBackward

$Env:GHQ_ROOT = "$HOME\workspace"
$Env:GHUX_ALIASES_PATH = "$HOME\.ghux_aliases"
. $PSScriptRoot/chezmoi.ps1
