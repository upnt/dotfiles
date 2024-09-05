# Self-elevate the script if required
if (-Not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] 'Administrator')) {
  if ([int](Get-CimInstance -Class Win32_OperatingSystem | Select-Object -ExpandProperty BuildNumber) -ge 6000) {
    $CommandLine = "-NoExit -File `"" + $MyInvocation.MyCommand.Path + "`" " + $MyInvocation.UnboundArguments
    Start-Process -Wait -FilePath PowerShell.exe -Verb Runas -ArgumentList $CommandLine
    Exit
  }
}

git clone https://github.com/upnt/nvim-dein $HOME/AppData/Local/nvim
winget install --id "Neovim.Neovim"
winget install --id "TheBrowserCompany.Arc"
winget install --id "Microsoft.PowerShell"
winget install --id "GitHub.cli"
winget install --id "Git.Git"
winget install --id "7zip.7zip"
winget install --id "lsd-rs.lsd"
winget install --id "sharkdp.bat"
winget install --id "sharkdp.fd"
winget install --id "dandavison.delta"
winget install "Password Manager SafeInCloud" -s msstore
