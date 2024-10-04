# Self-elevate the script if required
If (-Not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] 'Administrator')) {
  If ([int](Get-CimInstance -Class Win32_OperatingSystem | Select-Object -ExpandProperty BuildNumber) -ge 6000) {
    $CommandLine = "-NoExit -File `"" + $MyInvocation.MyCommand.Path + "`" " + $MyInvocation.UnboundArguments
    Start-Process -Wait -FilePath PowerShell.exe -Verb Runas -ArgumentList $CommandLine
    Exit
  }
}

echo "Install pkgs..."
winget install --allow-reboot --silent --accept-package-agreements --accept-source-agreements --disable-interactivity --id "gerardog.gsudo" >$null
$Env:PATH = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User") 

gsudo winget install --allow-reboot --silent --accept-package-agreements --accept-source-agreements --disable-interactivity --id "Microsoft.PowerShell" >$null
gsudo winget install --allow-reboot --silent --accept-package-agreements --accept-source-agreements --disable-interactivity --id "Zen-Team.Zen-Browser.Optimized" >$null
gsudo winget install --allow-reboot --silent --accept-package-agreements --accept-source-agreements --disable-interactivity --id "GitHub.cli" >$null
gsudo winget install --allow-reboot --silent --accept-package-agreements --accept-source-agreements --disable-interactivity --id "Git.Git" >$null
gsudo winget install --allow-reboot --silent --accept-package-agreements --accept-source-agreements --disable-interactivity --id "7zip.7zip" >$null
gsudo winget install --allow-reboot --silent --accept-package-agreements --accept-source-agreements --disable-interactivity --id "DevToys-app.DevToys" >$null
gsudo winget install --allow-reboot --silent --accept-package-agreements --accept-source-agreements --disable-interactivity --id "Microsoft.PowerToys" >$null
gsudo winget install --allow-reboot --silent --accept-package-agreements --accept-source-agreements --disable-interactivity --id "Neovim.Neovim" >$null
gsudo winget install --allow-reboot --silent --accept-package-agreements --accept-source-agreements --disable-interactivity --id "equalsraf.neovim-qt" >$null
gsudo winget install --allow-reboot --silent --accept-package-agreements --accept-source-agreements --disable-interactivity --id "lsd-rs.lsd" >$null
gsudo winget install --allow-reboot --silent --accept-package-agreements --accept-source-agreements --disable-interactivity --id "sharkdp.bat" >$null
gsudo winget install --allow-reboot --silent --accept-package-agreements --accept-source-agreements --disable-interactivity --id "sharkdp.fd" >$null
gsudo winget install --allow-reboot --silent --accept-package-agreements --accept-source-agreements --disable-interactivity --id "junegunn.fzf" >$null
gsudo winget install --allow-reboot --silent --accept-package-agreements --accept-source-agreements --disable-interactivity --id "ajeetdsouza.zoxide" >$null
gsudo winget install --allow-reboot --silent --accept-package-agreements --accept-source-agreements --disable-interactivity --id "dandavison.delta" >$null
gsudo winget install --allow-reboot --silent --accept-package-agreements --accept-source-agreements --disable-interactivity --id "BurntSushi.ripgrep.MSVC" >$null
gsudo winget install --allow-reboot --silent --accept-package-agreements --accept-source-agreements --disable-interactivity "Password Manager SafeInCloud" -s msstore >$null
echo "Installed"

$Env:PATH = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User") 

git clone https://github.com/Shougo/dpp.vim $HOME/.cache/dpp/repos/github.com/Shougo/dpp.vim
git clone https://github.com/Shougo/dpp-ext-installer $HOME/.cache/dpp/repos/github.com/Shougo/dpp-ext-installer
git clone https://github.com/Shougo/dpp-protocol-git $HOME/.cache/dpp/repos/github.com/Shougo/dpp-protocol-git
git clone https://github.com/Shougo/dpp-ext-toml $HOME/.cache/dpp/repos/github.com/Shougo/dpp-ext-toml
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
