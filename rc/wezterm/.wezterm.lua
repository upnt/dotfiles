local wezterm = require 'wezterm'

return {
    color_scheme = "iceberg-dark",
    font_size = 14.0,
    font = wezterm.font({
        family = 'HackGen35 Console NFJ',
        harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' },
    }),
    default_prog = { 'C:\\Users\\shun\\AppData\\Local\\Microsoft\\WindowsApps\\Microsoft.PowerShell_8wekyb3d8bbwe\\pwsh.exe' },
    default_cwd = "~/workspace",
}
