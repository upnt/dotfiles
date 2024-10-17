# Self-elevate the script if required
If (-Not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] 'Administrator')) {
  If ([int](Get-CimInstance -Class Win32_OperatingSystem | Select-Object -ExpandProperty BuildNumber) -ge 6000) {
    $CommandLine = "-NoExit -File `"" + $MyInvocation.MyCommand.Path + "`" " + $MyInvocation.UnboundArguments
    Start-Process -Wait -FilePath PowerShell.exe -Verb Runas -ArgumentList $CommandLine
    Exit
  }
}

function __winget_install_id($package)
{
    echo "Install $package from winget"
    gsudo winget install --allow-reboot --silent --accept-package-agreements --accept-source-agreements --disable-interactivity --id $package -s winget >$null
}

function __winget_install_ms($package)
{
    echo "Install $package from msstore"
    gsudo winget install --allow-reboot --silent --accept-package-agreements --accept-source-agreements --disable-interactivity $package -s msstore >$null
}

echo "Install pkgs..."
winget install --allow-reboot --silent --accept-package-agreements --accept-source-agreements --disable-interactivity --id "gerardog.gsudo" >$null
$Env:PATH = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User") 

__winget_install_id("Microsoft.PowerShell")
__winget_install_id("Zen-Team.Zen-Browser.Optimized")
__winget_install_id("Google.Chrome")
__winget_install_id("GitHub.cli")
__winget_install_id("Git.Git")
__winget_install_id("7zip.7zip")
__winget_install_id("DevToys-app.DevToys")
__winget_install_id("Microsoft.PowerToys")
__winget_install_id("Neovim.Neovim")
__winget_install_id("equalsraf.neovim-qt")
__winget_install_id("lsd-rs.lsd")
__winget_install_id("sharkdp.bat")
__winget_install_id("sharkdp.fd")
__winget_install_id("junegunn.fzf")
__winget_install_id("ajeetdsouza.zoxide")
__winget_install_id("dandavison.delta")
__winget_install_id("BurntSushi.ripgrep.MSVC")
__winget_install_id("Discord.Discord")
__winget_install_ms("Password Manager SafeInCloud")
__winget_install_ms("9P64KGF20H0T")
echo "Installed"

$Env:PATH = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User") 

git clone https://github.com/Shougo/dpp.vim $HOME/.cache/dpp/repos/github.com/Shougo/dpp.vim
git clone https://github.com/Shougo/dpp-ext-installer $HOME/.cache/dpp/repos/github.com/Shougo/dpp-ext-installer
git clone https://github.com/Shougo/dpp-protocol-git $HOME/.cache/dpp/repos/github.com/Shougo/dpp-protocol-git
git clone https://github.com/Shougo/dpp-ext-toml $HOME/.cache/dpp/repos/github.com/Shougo/dpp-ext-toml
git clone https://github.com/Shougo/dpp-ext-lazy $HOME/.cache/dpp/repos/github.com/Shougo/dpp-ext-lazy
git clone https://github.com/vim-denops/denops.vim $HOME/.cache/dpp/repos/github.com/vim-denops/denops.vim

If ("$(Get-Command deno -ErrorAction SilentlyContinue)" -eq "") {
	irm https://deno.land/install.ps1 | iex
}

If ("$(Get-Command rg -ErrorAction SilentlyContinue)" -ne "") {
    If ("$(Get-ChildItem -File "$HOME\AppData\Local\Microsoft\Windows\Fonts" -ErrorAction SilentlyContinue | rg UDEVGothic )" -eq "") {
        echo ""
        echo "Downloading UDEVGothic..."
        [string] $filePath = "$(Get-Location)\UDEVGothic_NF_v2.0.0.zip"
        [string] $destPath = "$(Get-Location)\UDEVGothic_NF_v2.0.0"
        [string] $uri = "https://github.com/yuru7/udev-gothic/releases/download/v2.0.0/UDEVGothic_NF_v2.0.0.zip"
        Invoke-WebRequest -Uri $uri -OutFile $filePath -UseBasicParsing
        Expand-Archive -Path $filePath -DestinationPath "$(Get-Location)"
	mkdir "$HOME\FontTemp"
        foreach ($item in $(Get-ChildItem -File "$destPath")) {
            Move-Item $item.FullName "$HOME\FontTemp"
        }
        Remove-Item $filePath
        Remove-Item -Recurse -Force $destPath
        echo ""
        echo "Downloaded UDEVGothic to $HOME\FontTemp."
    }
}
