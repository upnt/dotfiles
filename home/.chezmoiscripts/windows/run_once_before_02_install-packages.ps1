$PATH=$([Environment]::GetEnvironmentVariable("PATH", "User"))
If ("$(Get-Command deno -ErrorAction SilentlyContinue)" -eq "") {
	irm https://deno.land/install.ps1 | iex
}

go install github.com/x-motemen/ghq@latest
cargo install lsd bat ripgrep git-delta fd-find --locked
