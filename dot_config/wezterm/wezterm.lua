local wezterm = require("wezterm")

local config = {
	default_prog = { "/bin/zsh" },
	scrollback_lines = 10000,
	hyperlink_rules = wezterm.default_hyperlink_rules(),
	font = wezterm.font_with_fallback({
        "JetBrains Mono",
        "Fira code",
		"Mononoki",
	}),
	font_size = 12,
    color_scheme = 'Catppuccin Mocha',
    tab_bar_at_bottom = true,
    window_padding = {
        left = 0,
        right = 0,
        bottom = 0,
        top = 0,
    }
}

return config
