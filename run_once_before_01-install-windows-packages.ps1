# Self-elevate the script if required
If (-Not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] 'Administrator')) {
  If ([int](Get-CimInstance -Class Win32_OperatingSystem | Select-Object -ExpandProperty BuildNumber) -ge 6000) {
    $CommandLine = "-NoExit -File `"" + $MyInvocation.MyCommand.Path + "`" " + $MyInvocation.UnboundArguments
    Start-Process -Wait -FilePath PowerShell.exe -Verb Runas -ArgumentList $CommandLine
    Exit
  }
}

winget install --allow-reboot --silent --accept-package-agreements --accept-source-agreements --disable-interactivity --id "gerardog.gsudo"
$Env:PATH = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User") 

gsudo winget install --allow-reboot --silent --accept-package-agreements --accept-source-agreements --disable-interactivity --id "Microsoft.PowerShell"
gsudo winget install --allow-reboot --silent --accept-package-agreements --accept-source-agreements --disable-interactivity --id "TheBrowserCompany.Arc"
gsudo winget install --allow-reboot --silent --accept-package-agreements --accept-source-agreements --disable-interactivity --id "GitHub.cli"
gsudo winget install --allow-reboot --silent --accept-package-agreements --accept-source-agreements --disable-interactivity --id "Git.Git"
gsudo winget install --allow-reboot --silent --accept-package-agreements --accept-source-agreements --disable-interactivity --id "7zip.7zip"
gsudo winget install --allow-reboot --silent --accept-package-agreements --accept-source-agreements --disable-interactivity --id "DevToys-app.DevToys"
gsudo winget install --allow-reboot --silent --accept-package-agreements --accept-source-agreements --disable-interactivity --id "Microsoft.PowerToys"
gsudo winget install --allow-reboot --silent --accept-package-agreements --accept-source-agreements --disable-interactivity --id "Neovim.Neovim"
gsudo winget install --allow-reboot --silent --accept-package-agreements --accept-source-agreements --disable-interactivity --id "lsd-rs.lsd"
gsudo winget install --allow-reboot --silent --accept-package-agreements --accept-source-agreements --disable-interactivity --id "sharkdp.bat"
gsudo winget install --allow-reboot --silent --accept-package-agreements --accept-source-agreements --disable-interactivity --id "sharkdp.fd"
gsudo winget install --allow-reboot --silent --accept-package-agreements --accept-source-agreements --disable-interactivity --id "dandavison.delta"
gsudo winget install --allow-reboot --silent --accept-package-agreements --accept-source-agreements --disable-interactivity --id "BurntSushi.ripgrep.MSVC"
gsudo winget install --allow-reboot --silent --accept-package-agreements --accept-source-agreements --disable-interactivity "Password Manager SafeInCloud" -s msstore

$Env:PATH = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User") 

If ("$(Get-Command neovide -ErrorAction SilentlyContinue)" -eq "") {
    [string] $filePath = "$(Get-Location)\neovide.msi"
    [string] $uri = "https://github.com/neovide/neovide/releases/latest/download/neovide.msi"
    Invoke-WebRequest -Uri $uri -OutFile $filePath -UseBasicParsing
    cmd /c "msiexec.exe /i $filePath"
    Remove-Item $filePath
}

git clone https://github.com/Shougo/dpp.vim $HOME/.cache/dpp/repos/github.com/Shougo/dpp.vim
git clone https://github.com/Shougo/dpp-ext-installer $HOME/.cache/dpp/repos/github.com/Shougo/dpp-ext-installer
git clone https://github.com/Shougo/dpp-ext-toml $HOME/.cache/dpp/repos/github.com/Shougo/dpp-ext-toml
git clone https://github.com/vim-denops/denops.vim $HOME/.cache/dpp/repos/github.com/vim-denops/denops.vim
