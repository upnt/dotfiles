$PATH=$([Environment]::GetEnvironmentVariable("PATH", "User"))
If ( -not $PATH.Contains("$HOME\.local\bin") ) {
    [Environment]::SetEnvironmentVariable("PATH", "$PATH;$HOME\.local\bin", "User")
}
