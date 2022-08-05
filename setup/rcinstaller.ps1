Param( [string]$selector )

$project_path = Split-Path -parent (Split-Path -parent $MyInvocation.MyCommand.Path)

if ([string]::IsNullOrEmpty($selector)) {
    Write-Host "1: vim config"
    Write-Host "2: neovim config"
    Write-Host "3: dein"
    Write-Host "4: deno"
    Write-Host "5: bash"
    Write-Host "6: powershell"
    Write-Host "7: alacritty"
    Write-Host "8: wezterm"
    $selector = Read-Host "Chouse installation(ex. 2,3,4,5)"
}

$arr = $selector -split ' *[, ] *'
if ($arr.Length -eq 0) {
    exit 0
}
# install vimrc
if ($arr.Contains('1')) {
    Write-Host "Installing vimrc..."
    New-Item ~/.vim -ItemType Directory
    Copy-Item -Recurse $project_path/rc/vim/* ~/.vim
}

# install neovimrc
if ($arr.Contains('2')) {
    Write-Host "Installing neovimrc..."
    New-Item -p ~/.config/nvim -ItemType Directory
    Copy-Item -Recurse $project_path/rc/nvim/* ~/.config/nvim
}

# install dein.vim
if ($arr.Contains('3')) {
    Write-Host "Installing dein.vim..."
    Invoke-WebRequest https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.ps1 -OutFile installer.ps1
    # For example, we just use `~/.cache/dein` as installation directory
    .\installer.ps1 ~/.cache/dein
    Remove-Item installer.ps1
}

# install deno
if ($arr.Contains('4')) {
    Write-Host "Installing deno..."
    Invoke-WebRequest https://deno.land/x/install/install.ps1 -useb | Invoke-Expression
}

# install powershell
if ($arr.Contains('5')) {
    if ([string]::IsNullOrEmpty($PROFILE)) {
        Write-Host "Installing powershell configs..."
		Copy-Item -Recurse $project_path/rc/powershell/* `dirname $PROFILE`
	} else {
		Write-Host "PROFILE is not set"
    }
}

# install alacritty
if ($arr.Contains('6')) {
    if ([string]::IsNullOrEmpty($XDG_CONFIG_HOME)) {
        Write-Host "Installing alacritty configs..."
        New-Item $XDG_CONFIG_HOME/alacritty
		Copy-Item -Recurse $project_path/rc/alacritty/* $XDG_CONFIG_HOME/alacritty
    } elseif ([string]::IsNullOrEmpty($APPDATA)) {
        New-Item $APPDATA/alacritty -ItemType Directory
		Copy-Item -Recurse $project_path/rc/alacritty/* $APPDATA/alacritty
	} else {
        Write-Host "enable to find config directory"
    }
}

# install wezterm
if ($arr.Contains('7')) {
    Write-Host "Installing alacritty configs..."
	Copy-Item -Recurse $project_path/rc/wezterm/.wezterm.lua ~
}
