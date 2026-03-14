local wezterm = require 'wezterm'
local config = {}

if wezterm.config_builder then
  config = wezterm.config_builder()
end

config.enable_tab_bar = true
config.hide_tab_bar_if_only_one_tab = true
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = false

config.default_domain = 'WSL:Ubuntu'

config.enable_wayland = false

config.wsl_domains = {
  {
    name = 'Ubuntu',
    distribution = 'Ubuntu',
    username = '',
  },
}

config.set_environment_variables = {
  -- TERM = 'xterm-256color',
}

config.keys = {
  { key = 'h', mods = 'CTRL|SHIFT', action = wezterm.action.ActivatePaneByDirection 'Left' },
  { key = 'j', mods = 'CTRL|SHIFT', action = wezterm.action.ActivatePaneByDirection 'Down' },
  { key = 'k', mods = 'CTRL|SHIFT', action = wezterm.action.ActivatePaneByDirection 'Up' },
  { key = 'l', mods = 'CTRL|SHIFT', action = wezterm.action.ActivatePaneByDirection 'Right' },
  { key = 'v', mods = 'CTRL|SHIFT', action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' } },
  { key = 's', mods = 'CTRL|SHIFT', action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' } },
  { key = 'w', mods = 'CTRL|SHIFT', action = wezterm.action.CloseCurrentPane { confirm = true } },
  { key = 'f', mods = 'CTRL|SHIFT', action = wezterm.action.SpawnCommandInNewTab { domain = 'WSL:Ubuntu', args = { 'zsh', '-l', '-c', 'wezterm-mux' } } },
  { key = 't', mods = 'CTRL|SHIFT', action = wezterm.action.SpawnCommandInNewTab { domain = 'WSL:Ubuntu', args = { 'zsh', '-l' } } },
  { key = 'c', mods = 'CTRL|SHIFT|ALT', action = wezterm.action.CopyTo 'Clipboard' },
  { key = 'v', mods = 'CTRL|SHIFT|ALT', action = wezterm.action.PasteFrom 'Clipboard' },
}

config.mouse_bindings = {
  {
    event = { Up = { streak = 1, button = 'Left' } },
    mods = 'CTRL',
    action = wezterm.action.ActivatePaneByDirection 'Last',
  },
}

config.font = wezterm.font 'JetBrainsMono Nerd Font'
config.font_size = 11.0

config.enable_scroll_bar = true

config.default_prog = { 'wsl.exe', '--distribution', 'Ubuntu', '--', 'zsh', '-l' }

config.color_scheme = 'nord'

config.window_padding = {
  left = 4,
  right = 4,
  top = 4,
  bottom = 4,
}

config.window_background_opacity = 0.95

return config
