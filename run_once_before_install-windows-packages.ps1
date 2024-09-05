winget install --allow-reboot --silent --accept-package-agreements --accept-source-agreements --disable-interactivity --id "gerardog.gsudo"
$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User") 

gsudo winget install --allow-reboot --silent --accept-package-agreements --accept-source-agreements --disable-interactivity --id "Neovim.Neovim"
gsudo winget install --allow-reboot --silent --accept-package-agreements --accept-source-agreements --disable-interactivity --id "TheBrowserCompany.Arc"
gsudo winget install --allow-reboot --silent --accept-package-agreements --accept-source-agreements --disable-interactivity --id "Microsoft.PowerShell"
gsudo winget install --allow-reboot --silent --accept-package-agreements --accept-source-agreements --disable-interactivity --id "GitHub.cli"
gsudo winget install --allow-reboot --silent --accept-package-agreements --accept-source-agreements --disable-interactivity --id "Git.Git"
gsudo winget install --allow-reboot --silent --accept-package-agreements --accept-source-agreements --disable-interactivity --id "7zip.7zip"
gsudo winget install --allow-reboot --silent --accept-package-agreements --accept-source-agreements --disable-interactivity --id "lsd-rs.lsd"
gsudo winget install --allow-reboot --silent --accept-package-agreements --accept-source-agreements --disable-interactivity --id "sharkdp.bat"
gsudo winget install --allow-reboot --silent --accept-package-agreements --accept-source-agreements --disable-interactivity --id "sharkdp.fd"
gsudo winget install --allow-reboot --silent --accept-package-agreements --accept-source-agreements --disable-interactivity --id "dandavison.delta"
gsudo winget install --allow-reboot --silent --accept-package-agreements --accept-source-agreements --disable-interactivity "Password Manager SafeInCloud" -s msstore

git clone https://github.com/upnt/nvim-dein "$HOME/AppData/Local/nvim"

