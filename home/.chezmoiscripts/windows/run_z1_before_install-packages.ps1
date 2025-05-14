$Env:PATH = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User") 
If ("$(Get-Command deno -ErrorAction SilentlyContinue)" -eq "") {
	irm https://deno.land/install.ps1 | iex
}

go install github.com/x-motemen/ghq@latest
cargo install lsd bat ripgrep git-delta fd-find zoxide --locked
