-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
config.color_scheme = 'nightfox'
config.window_decorations = 'RESIZE'
config.enable_tab_bar = false
config.font = wezterm.font_with_fallback({
  { family = 'JetBrains Mono', harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' }, },
  { family = 'JetBrains Mono', assume_emoji_presentation = true },
})
config.font_size = 13.0

config.use_ime = true
config.macos_forward_to_ime_modifier_mask = "CTRL"

config.audible_bell = "Disabled"

-- and finally, return the configuration to wezterm
return config
