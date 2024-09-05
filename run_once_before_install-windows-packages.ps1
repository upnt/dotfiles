# Self-elevate the script if required
if (-Not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] 'Administrator')) {
  if ([int](Get-CimInstance -Class Win32_OperatingSystem | Select-Object -ExpandProperty BuildNumber) -ge 6000) {
    $CommandLine = "-NoExit -File `"" + $MyInvocation.MyCommand.Path + "`" " + $MyInvocation.UnboundArguments
    Start-Process -Wait -FilePath PowerShell.exe -Verb Runas -ArgumentList $CommandLine
    Exit
  }
}

git clone https://github.com/upnt/nvim-dein "$HOME/AppData/Local/nvim"

winget install --allow-reboot --silent --accept-package-agreements --accept-source-agreements --id "Neovim.Neovim"
winget install --allow-reboot --silent --accept-package-agreements --accept-source-agreements --id "TheBrowserCompany.Arc"
winget install --allow-reboot --silent --accept-package-agreements --accept-source-agreements --id "Microsoft.PowerShell"
winget install --allow-reboot --silent --accept-package-agreements --accept-source-agreements --id "GitHub.cli"
winget install --allow-reboot --silent --accept-package-agreements --accept-source-agreements --id "Git.Git"
winget install --allow-reboot --silent --accept-package-agreements --accept-source-agreements --id "7zip.7zip"
winget install --allow-reboot --silent --accept-package-agreements --accept-source-agreements --id "lsd-rs.lsd"
winget install --allow-reboot --silent --accept-package-agreements --accept-source-agreements --id "sharkdp.bat"
winget install --allow-reboot --silent --accept-package-agreements --accept-source-agreements --id "sharkdp.fd"
winget install --allow-reboot --silent --accept-package-agreements --accept-source-agreements --id "dandavison.delta"
winget install --allow-reboot --silent --accept-package-agreements --accept-source-agreements "Password Manager SafeInCloud" -s msstore

