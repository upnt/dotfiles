# Self-elevate the script if required
If (-Not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] 'Administrator'))
{
	Write-Error "This script must be executed as an administrator"
	Exit 1
}
chcp 65001
Write-Output ""

function __winget_install_id($package)
{
	Write-Output "Installing $package from winget"
	$buf = winget install --allow-reboot --silent --accept-package-agreements --accept-source-agreements --disable-interactivity --id $package -s winget
	if ($LASTEXITCODE -eq -1978335212)
	{
		Write-Output $buf
		Write-Output ""
		Write-Error "Package is not exists."
	}
}


$oldPreference = $ErrorActionPreference
$ErrorActionPreference = "Stop"

try
{
	Write-Output "Install pkgs..."
	Write-Output "Installing VisualStudio BuildTools"
	winget install --id Microsoft.VisualStudio.2022.Community --override "--add Microsoft.VisualStudio.Workload.NativeDesktop;includeRecommended --focusedUi --wait"
	__winget_install_id("Google.Chrome")
	__winget_install_id("Zen-Team.Zen-Browser")
	
	__winget_install_id("7zip.7zip")
	__winget_install_id("DevToys-app.DevToys")
	__winget_install_id("Microsoft.PowerToys")
	__winget_install_id("GitHub.cli")

	__winget_install_id("Discord.Discord")
	__winget_install_id("SlackTechnologies.Slack")

	__winget_install_id("Neovim.Neovim")
	__winget_install_id("Microsoft.VisualStudioCode")
	__winget_install_id("equalsraf.neovim-qt")
	__winget_install_id("SumatraPDF.SumatraPDF")
	__winget_install_id("beekeeper-studio.beekeeper-studio")
	
	__winget_install_id("junegunn.fzf")
	__winget_install_id("jqlang.jq")
	__winget_install_id("GoLang.Go")
	__winget_install_id("rustlang.rustup")

	Write-Output "Installed packages. Automatically exits after 5 seconds..."
	$_Success = $true
	Start-Sleep -Seconds 5
} catch
{
	Write-Output "An error occured."
	Read-Host -Prompt "Press any key to exit"
	$ErrorActionPreference = "Continue"
	$_Success = $false
} finally {
	$ErrorActionPreference = $oldPreference
}

if ($_Success) {
	exit 0
} else {
	exit 1
}
