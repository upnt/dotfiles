# Self-elevate the script if required
If (-Not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] 'Administrator'))
{
	Write-Error "This script must be executed as an administrator"
	Exit 1
}
chcp 65001
winget update --all
if (Get-Command rustup -ErrorAction SilentlyContinue) {
	rustup update
}
Exit 0
