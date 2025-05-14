$Env:PATH = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
If ( -not $Env:PATH.Contains("$HOME\.local\bin") ) {
    [Environment]::SetEnvironmentVariable("Env:PATH", "$Env:PATH;$HOME\.local\bin", "User")
}
