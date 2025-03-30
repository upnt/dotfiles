# Self-elevate the script if required
If (-Not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] 'Administrator'))
{
	If ([int](Get-CimInstance -Class Win32_OperatingSystem | Select-Object -ExpandProperty BuildNumber) -ge 6000)
	{
		$CommandLine = "-File `"" + $MyInvocation.MyCommand.Path + "`" " + $MyInvocation.UnboundArguments
		Start-Process -Wait -FilePath pwsh.exe -Verb Runas -ArgumentList $CommandLine
		Exit
	}
}
chcp 65001
winget update --all
exit 0
