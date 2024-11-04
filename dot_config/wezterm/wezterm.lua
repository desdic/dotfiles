local wezterm = require("wezterm")
local act = wezterm.action

local config = wezterm.config_builder()

local palette = {
	active_tab_bg = "#cba6f7",
	active_tab_fg = "#11111b",
	tab_color_bg = "#cba6f7",
	tab_color_fg = "#333333",
	background = "black",
	foreground = "#cdd6f4",
}

local mycatppuccin = wezterm.color.get_builtin_schemes()["Catppuccin Mocha (Gogh)"]
mycatppuccin.background = palette.background
mycatppuccin.foreground = palette.foreground

config.color_schemes = {
	["mycatppuccin"] = mycatppuccin,
}
config.color_scheme = "mycatppuccin"

config.font = wezterm.font("JetbrainsMono Nerd Font", { italic = false, weight = "DemiBold" })

config.font_size = 12

config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false
config.tab_max_width = 32

config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}

config.disable_default_quick_select_patterns = true
config.quick_select_patterns = {
	"[a-z-_.0-9]+\\.(?:com|dk|net)", -- hackish fqdn
	"[a-z-_0-9]+\\.(?:cc|c|h|go|md|csv|sh|lua|txt|yaml|yml|erb|rb|json|conf)", -- hackish filenames of interest
	"[0-9]+",
}

config.scrollback_lines = 5000

config.colors = {
	tab_bar = {
		active_tab = {
			fg_color = palette.active_tab_fg,
			bg_color = palette.active_tab_bg,
		},
	},
}

local function tab_title(tab_info)
	local title = tab_info.tab_title
	if title and #title > 0 then
		return title
	end
	return tab_info.active_pane.title
end

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
	local title = tab_title(tab)

	local start = ""
	if tab.tab_index == 0 then
		start = ""
	end

	if title and #title > config.tab_max_width - 4 then
		title = string.sub(title, 1, config.tab_max_width - 6) .. ".."
	end

	if tab.is_active then
		return {
			{ Foreground = { Color = palette.tab_color_fg } },
			{ Text = start },
			{ Text = " " .. title .. " " },
			{ Background = { Color = palette.tab_color_fg } },
			{ Foreground = { Color = palette.tab_color_bg } },
			{ Text = "" },
		}
	end
	return {
		{ Text = " " .. title .. " " },
	}
end)

wezterm.on("trigger-nvim-with-scrollback", function(window, pane)
	local scrollback = pane:get_lines_as_text()

	-- Create a temporary file to pass to vim
	local name = os.tmpname()
	local f = io.open(name, "w+")
	f:write(scrollback)
	f:flush()
	f:close()

	-- Open a new window running vim and tell it to open the file
	window:perform_action(
		act({ SpawnCommandInNewWindow = {
			args = { "nvim", name },
		} }),
		pane
	)

	-- wait "enough" time for vim to read the file before we remove it.
	-- The window creation and process spawn are asynchronous
	-- wrt. running this script and are not awaitable, so we just pick
	-- a number.
	wezterm.sleep_ms(1000)
	os.remove(name)
end)

config.keys = {
	{ key = " ", mods = "SHIFT|CTRL", action = act.QuickSelect },
	{ key = "e", mods = "CTRL|SHIFT", action = act({ EmitEvent = "trigger-nvim-with-scrollback" }) },
	{ key = "h", mods = "ALT", action = act.ActivateTabRelative(-1) },
	{ key = "l", mods = "ALT", action = act.ActivateTabRelative(1) },
	{ key = "h", mods = "SHIFT|ALT", action = act.MoveTabRelative(-1) },
	{ key = "l", mods = "SHIFT|ALT", action = act.MoveTabRelative(1) },
	{
		key = "o",
		mods = "CTRL|SHIFT",
		action = act.QuickSelectArgs({
			patterns = {
				"https?://\\S+",
			},
			action = wezterm.action_callback(function(win, pane)
				local url = win:get_selection_text_for_pane(pane)
				wezterm.open_with(url)
			end),
		}),
	},
	{
		key = "F2",
		mods = "NONE",
		action = act.PromptInputLine({
			description = "Enter new name for tab",
			action = wezterm.action_callback(function(window, pane, line)
				if line then
					window:active_tab():set_title(line)
				end
			end),
		}),
	},
}

return config
