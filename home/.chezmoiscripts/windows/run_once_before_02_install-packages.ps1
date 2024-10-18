git clone https://github.com/Shougo/dpp.vim $HOME/.cache/dpp/repos/github.com/Shougo/dpp.vim
git clone https://github.com/Shougo/dpp-ext-installer $HOME/.cache/dpp/repos/github.com/Shougo/dpp-ext-installer
git clone https://github.com/Shougo/dpp-protocol-git $HOME/.cache/dpp/repos/github.com/Shougo/dpp-protocol-git
git clone https://github.com/Shougo/dpp-ext-toml $HOME/.cache/dpp/repos/github.com/Shougo/dpp-ext-toml
git clone https://github.com/Shougo/dpp-ext-lazy $HOME/.cache/dpp/repos/github.com/Shougo/dpp-ext-lazy
git clone https://github.com/vim-denops/denops.vim $HOME/.cache/dpp/repos/github.com/vim-denops/denops.vim

If ("$(Get-Command deno -ErrorAction SilentlyContinue)" -eq "") {
	irm https://deno.land/install.ps1 | iex
}

If ("$(Get-Command rg -ErrorAction SilentlyContinue)" -ne "") {
    If ("$(Get-ChildItem -File "$HOME\AppData\Local\Microsoft\Windows\Fonts" -ErrorAction SilentlyContinue | rg UDEVGothic )" -eq "") {
        echo ""
        echo "Downloading UDEVGothic..."
        [string] $filePath = "$(Get-Location)\UDEVGothic_NF_v2.0.0.zip"
        [string] $destPath = "$(Get-Location)\UDEVGothic_NF_v2.0.0"
        [string] $uri = "https://github.com/yuru7/udev-gothic/releases/download/v2.0.0/UDEVGothic_NF_v2.0.0.zip"
        Invoke-WebRequest -Uri $uri -OutFile $filePath -UseBasicParsing
        Expand-Archive -Path $filePath -DestinationPath "$(Get-Location)"
	mkdir "$HOME\FontTemp"
        foreach ($item in $(Get-ChildItem -File "$destPath")) {
            Move-Item $item.FullName "$HOME\FontTemp"
        }
        Remove-Item $filePath
        Remove-Item -Recurse -Force $destPath
        echo ""
        echo "Downloaded UDEVGothic to $HOME\FontTemp."
    }
}
