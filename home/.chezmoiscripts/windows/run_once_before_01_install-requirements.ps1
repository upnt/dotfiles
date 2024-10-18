# Self-elevate the script if required
If (-Not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] 'Administrator')) {
  If ([int](Get-CimInstance -Class Win32_OperatingSystem | Select-Object -ExpandProperty BuildNumber) -ge 6000) {
    $CommandLine = "-File `"" + $MyInvocation.MyCommand.Path + "`" " + $MyInvocation.UnboundArguments
    Start-Process -Wait -FilePath PowerShell.exe -Verb Runas -ArgumentList $CommandLine
    Exit
  }
}

chcp 65001
Write-Output ""

function __winget_install_id($package)
{
    Write-Output "Install $package from winget"
    $buf = winget install --allow-reboot --silent --accept-package-agreements --accept-source-agreements --disable-interactivity --id $package -s winget
    if ($LASTEXITCODE -eq -1978335212) {
    	Write-Output $buf
    	Write-Output ""
    	Write-Error "Package is not exists."
    }
}

function __winget_install_ms($package)
{
    Write-Output "Install $package from msstore"
    $buf = winget install --allow-reboot --silent --accept-package-agreements --accept-source-agreements --disable-interactivity $package -s msstore
    if ($LASTEXITCODE -eq -1978335212) {
    	Write-Output $buf
    	Write-Output ""
    	Write-Error "Package is not exists."
    }
}

$ErrorActionPreference = "Stop"

try {
	Write-Output "Install pkgs..."
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
	$Env:PATH = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User") 
	Write-Output "Installed packages. Automatically exits after 5 seconds..."
	Start-Sleep -Seconds 5
} catch {
	Write-Output "An error occured."
	Read-Host -Prompt "Press any key to exit"
}

$ErrorActionPreference = "Continue"
