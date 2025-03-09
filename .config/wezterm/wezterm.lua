local wezterm = require 'wezterm'

return {
    color_scheme = 'Dracula (Official)',
    font = wezterm.font 'Fira Code',
    font_size = 12,
    enable_tab_bar = false,
    window_close_confirmation = 'NeverPrompt',
    harfbuzz_features = { 'calt=0' }, -- disable ligatures
    scrollback_lines = 5000,
    window_padding = { left = 1, top = 2 }
}
