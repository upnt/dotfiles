Install-WindowsUpdate -AcceptEula
Set-WindowsExplorerOptions -EnableShowHiddenFilesFoldersDrives -EnableShowFileExtensions
Disable-BingSearch
Set-BoxstarterTaskbarOptions -Size Small -Dock Bottom -MultiMonitorOff
wsl --install -d ubuntu

cinst busybox
cinst cmake
cinst findutils
cinst git
cinst make
cinst ripgrep
cinst wget

cinst fzf
cinst gh
cinst mingw

cinst cica
cinst font-hackgen
cinst font-hackgen-nerd

cinst powershell-core
cinst wezterm
cinst vscode
cinst devtoys
cinst drawio
cinst docker-desktop

cinst firefox
cinst googlechrome

cinst line
cinst zoom
cinst slack
cinst microsoft-teams
