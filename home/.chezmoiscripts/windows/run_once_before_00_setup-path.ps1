$Env:PATH = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User") 
If ( -not $PATH.Contains("$HOME\.local\bin") ) {
    [Environment]::SetEnvironmentVariable("PATH", "$PATH;$HOME\.local\bin", "User")
}
