local wezterm = require("wezterm")
local act = wezterm.action

local config = {
	default_prog = { "/bin/zsh" },
	front_end = "OpenGL",
	scrollback_lines = 10000,
	hyperlink_rules = wezterm.default_hyperlink_rules(),
	font = wezterm.font_with_fallback({
		"JetBrains Mono",
		"Fira code",
		"Mononoki",
	}),
	font_size = 12,
	color_scheme = "Catppuccin Mocha",
	colors = {
		background = "black",
	},
	tab_bar_at_bottom = true,

	-- remove border
	window_padding = {
		left = 0,
		right = 0,
		bottom = 0,
		top = 0,
	},

	unix_domains = {
		{ name = "private" },
		{ name = "work" },
	},

    -- search_editor = {
    --     editor = {"/usr/bin/nvim"},
    --     location = "NewTab"
    -- },

	-- disable all keybindings and define our own
	disable_default_key_bindings = true,

	keys = {
		{ key = "phys:Space", mods = "SHIFT|CTRL", action = act.QuickSelect },
		{ key = "h", mods = "ALT", action = act.ActivateTabRelative(-1) },
		{ key = "l", mods = "ALT", action = act.ActivateTabRelative(1) },
		{ key = "V", mods = "SHIFT|CTRL", action = act.PasteFrom("Clipboard") },
		{ key = "+", mods = "SHIFT|CTRL", action = act.IncreaseFontSize },
		{ key = "-", mods = "CTRL", action = act.DecreaseFontSize },
		{ key = "PageUp", mods = "NONE", action = act.ScrollByPage(-1) },
		{ key = "PageDown", mods = "NONE", action = act.ScrollByPage(1) },
		{ key = "Copy", mods = "NONE", action = act.CopyTo("Clipboard") },
		{ key = "Paste", mods = "NONE", action = act.PasteFrom("Clipboard") },
		{ key = "w", mods = "SHIFT|CTRL", action = act.CloseCurrentTab({ confirm = true }) },
		{ key = "C", mods = "CTRL", action = act.CopyTo("Clipboard") },
		{ key = "X", mods = "CTRL", action = act.ActivateCopyMode },
		{ key = "F", mods = "CTRL", action = act.Search("CurrentSelectionOrEmptyString") },
		{
			key = "O",
			mods = "CTRL",
			action = wezterm.action.QuickSelectArgs({
				label = "open url",
				patterns = {
					"https?://\\S+",
				},
				action = wezterm.action_callback(function(window, pane)
					local url = window:get_selection_text_for_pane(pane)
					wezterm.log_info("opening: " .. url)
					wezterm.open_with(url)
				end),
			}),
		},
		-- { key = "Y", mods = "CTRL", action = act.SearchViaEditor },
	},

	key_tables = {
		copy_mode = {
			{ key = "Tab", mods = "NONE", action = act.CopyMode("MoveForwardWord") },
			{ key = "Tab", mods = "SHIFT", action = act.CopyMode("MoveBackwardWord") },
			{ key = "Enter", mods = "NONE", action = act.CopyMode("MoveToStartOfNextLine") },
			{ key = "Escape", mods = "NONE", action = act.CopyMode("Close") },
			{ key = "Space", mods = "NONE", action = act.CopyMode({ SetSelectionMode = "Cell" }) },
			{ key = "$", mods = "NONE", action = act.CopyMode("MoveToEndOfLineContent") },
			{ key = "$", mods = "SHIFT", action = act.CopyMode("MoveToEndOfLineContent") },
			{ key = ",", mods = "NONE", action = act.CopyMode("JumpReverse") },
			{ key = "0", mods = "NONE", action = act.CopyMode("MoveToStartOfLine") },
			{ key = ";", mods = "NONE", action = act.CopyMode("JumpAgain") },
			{ key = "F", mods = "NONE", action = act.CopyMode({ JumpBackward = { prev_char = false } }) },
			{ key = "F", mods = "SHIFT", action = act.CopyMode({ JumpBackward = { prev_char = false } }) },
			{ key = "G", mods = "NONE", action = act.CopyMode("MoveToScrollbackBottom") },
			{ key = "G", mods = "SHIFT", action = act.CopyMode("MoveToScrollbackBottom") },
			{ key = "H", mods = "NONE", action = act.CopyMode("MoveToViewportTop") },
			{ key = "H", mods = "SHIFT", action = act.CopyMode("MoveToViewportTop") },
			{ key = "L", mods = "NONE", action = act.CopyMode("MoveToViewportBottom") },
			{ key = "L", mods = "SHIFT", action = act.CopyMode("MoveToViewportBottom") },
			{ key = "M", mods = "NONE", action = act.CopyMode("MoveToViewportMiddle") },
			{ key = "M", mods = "SHIFT", action = act.CopyMode("MoveToViewportMiddle") },
			{ key = "O", mods = "NONE", action = act.CopyMode("MoveToSelectionOtherEndHoriz") },
			{ key = "O", mods = "SHIFT", action = act.CopyMode("MoveToSelectionOtherEndHoriz") },
			{ key = "T", mods = "NONE", action = act.CopyMode({ JumpBackward = { prev_char = true } }) },
			{ key = "T", mods = "SHIFT", action = act.CopyMode({ JumpBackward = { prev_char = true } }) },
			{ key = "V", mods = "NONE", action = act.CopyMode({ SetSelectionMode = "Line" }) },
			{ key = "V", mods = "SHIFT", action = act.CopyMode({ SetSelectionMode = "Line" }) },
			{ key = "^", mods = "NONE", action = act.CopyMode("MoveToStartOfLineContent") },
			{ key = "^", mods = "SHIFT", action = act.CopyMode("MoveToStartOfLineContent") },
			{ key = "b", mods = "NONE", action = act.CopyMode("MoveBackwardWord") },
			{ key = "b", mods = "ALT", action = act.CopyMode("MoveBackwardWord") },
			{ key = "b", mods = "CTRL", action = act.CopyMode("PageUp") },
			{ key = "c", mods = "CTRL", action = act.CopyMode("Close") },
			{ key = "d", mods = "CTRL", action = act.CopyMode({ MoveByPage = 0.5 }) },
			{ key = "e", mods = "NONE", action = act.CopyMode("MoveForwardWordEnd") },
			{ key = "f", mods = "NONE", action = act.CopyMode({ JumpForward = { prev_char = false } }) },
			{ key = "f", mods = "ALT", action = act.CopyMode("MoveForwardWord") },
			{ key = "f", mods = "CTRL", action = act.CopyMode("PageDown") },
			{ key = "g", mods = "NONE", action = act.CopyMode("MoveToScrollbackTop") },
			{ key = "g", mods = "CTRL", action = act.CopyMode("Close") },
			{ key = "h", mods = "NONE", action = act.CopyMode("MoveLeft") },
			{ key = "j", mods = "NONE", action = act.CopyMode("MoveDown") },
			{ key = "k", mods = "NONE", action = act.CopyMode("MoveUp") },
			{ key = "l", mods = "NONE", action = act.CopyMode("MoveRight") },
			{ key = "m", mods = "ALT", action = act.CopyMode("MoveToStartOfLineContent") },
			{ key = "o", mods = "NONE", action = act.CopyMode("MoveToSelectionOtherEnd") },
			{ key = "q", mods = "NONE", action = act.CopyMode("Close") },
			{ key = "t", mods = "NONE", action = act.CopyMode({ JumpForward = { prev_char = true } }) },
			{ key = "u", mods = "CTRL", action = act.CopyMode({ MoveByPage = -0.5 }) },
			{ key = "v", mods = "NONE", action = act.CopyMode({ SetSelectionMode = "Cell" }) },
			{ key = "v", mods = "CTRL", action = act.CopyMode({ SetSelectionMode = "Block" }) },
			{ key = "w", mods = "NONE", action = act.CopyMode("MoveForwardWord") },
			{
				key = "y",
				mods = "NONE",
				action = act.Multiple({ { CopyTo = "ClipboardAndPrimarySelection" }, { CopyMode = "Close" } }),
			},
			{ key = "PageUp", mods = "NONE", action = act.CopyMode("PageUp") },
			{ key = "PageDown", mods = "NONE", action = act.CopyMode("PageDown") },
			{ key = "End", mods = "NONE", action = act.CopyMode("MoveToEndOfLineContent") },
			{ key = "Home", mods = "NONE", action = act.CopyMode("MoveToStartOfLine") },
			{ key = "LeftArrow", mods = "NONE", action = act.CopyMode("MoveLeft") },
			{ key = "LeftArrow", mods = "ALT", action = act.CopyMode("MoveBackwardWord") },
			{ key = "RightArrow", mods = "NONE", action = act.CopyMode("MoveRight") },
			{ key = "RightArrow", mods = "ALT", action = act.CopyMode("MoveForwardWord") },
			{ key = "UpArrow", mods = "NONE", action = act.CopyMode("MoveUp") },
			{ key = "DownArrow", mods = "NONE", action = act.CopyMode("MoveDown") },
		},

		search_mode = {
			{ key = "Enter", mods = "NONE", action = act.CopyMode("PriorMatch") },
			{ key = "Escape", mods = "NONE", action = act.CopyMode("Close") },
			{ key = "n", mods = "CTRL", action = act.CopyMode("NextMatch") },
			{ key = "p", mods = "CTRL", action = act.CopyMode("PriorMatch") },
			{ key = "r", mods = "CTRL", action = act.CopyMode("CycleMatchType") },
			{ key = "u", mods = "CTRL", action = act.CopyMode("ClearPattern") },
			{ key = "PageUp", mods = "NONE", action = act.CopyMode("PriorMatchPage") },
			{ key = "PageDown", mods = "NONE", action = act.CopyMode("NextMatchPage") },
			{ key = "UpArrow", mods = "NONE", action = act.CopyMode("PriorMatch") },
			{ key = "DownArrow", mods = "NONE", action = act.CopyMode("NextMatch") },
		},
	},
}

return config
