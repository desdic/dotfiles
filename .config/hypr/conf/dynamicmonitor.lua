local dm = require("hyprdynamic")

dm.config({
	-- Alias -> how to recognise the monitor. `desc` is a plain substring match on
	-- the monitor description; `name = "eDP-1"` or `match = function(mon) ... end`
	-- also work. A bare string is shorthand for { desc = "..." }.
	monitors = {
		laptop = { desc = "Lenovo Group Limited 0x4146" },
		ultragear = { desc = "LG Electronics LG ULTRAGEAR 106NTQD8W884" },
		dell_left = { desc = "Dell Inc. DELL U2722DE 78ML9H3" },
		dell_right = { desc = "Dell Inc. DELL U2722DE 4M6LV83" },
	},

	window_rules = {
		{ name = "mumble", match = { class = "info.mumble.Mumble" }, workspace = 1 },
		{ name = "dino", match = { class = "im.dino.Dino" }, workspace = 1, no_initial_focus = true },
		{ name = "tmux", match = { class = "tmux" }, workspace = 3 },
		{ name = "herdr", match = { class = "herdr" }, workspace = 3 },
		{ name = "chromium", match = { class = "chromium" }, workspace = 4 },
		{ name = "google-chrome", match = { class = "google-chrome" }, workspace = 4 },
		{ name = "spotify", match = { class = "^[Ss]potify$" }, workspace = 5, no_initial_focus = true },

		-- Rules without a workspace/monitor work too; they're just never used to move open windows.
		-- Ignore maximize requests from all apps.
		{ name = "suppress-maximize-events", match = { class = ".*" }, suppress_event = "maximize" },
		-- Fix some dragging issues with XWayland
		{
			name = "fix-xwayland-drags",
			match = { class = "^$", title = "^$", xwayland = true, float = true, fullscreen = false, pin = false },
			no_focus = true,
		},
	},

	-- First setup whose conditions all hold wins. Conditions:
	--   requires     = { ... }  all must be connected
	--   requires_any = { ... }  at least one must be connected
	--   excludes     = { ... }  none may be connected
	--   when         = function(ctx) return bool end   (ctx.connected[alias], ctx.monitors)
	setups = {
		{
			name = "home",
			requires = { "ultragear" },
			outputs = {
				laptop = { mode = "3840x2400@60", position = "0x0", scale = 1.5 },
				ultragear = { mode = "3440x1440@85", position = "2560x160", scale = 1 },
			},
			workspaces = {
				ultragear = { 1, 2, 3, 4, 5 },
				laptop = { 8 },
			},
		},
		{
			name = "office",
			requires = { "dell_left", "dell_right" },
			outputs = {
				dell_left = { mode = "2560x1440@60", position = "0x0", scale = 1 },
				dell_right = { mode = "2560x1440@60", position = "2560x0", scale = 1 },
				laptop = { mode = "3840x2400@60", position = "0x1440", scale = 1.5 },
			},
			workspaces = {
				dell_left = "1-3",
				dell_right = { 4, 5 },
				laptop = { 8 },
			},
		},
	},

	-- Used when no setup matches.
	default = {
		outputs = {
			laptop = { mode = "3840x2400@60", position = "auto", scale = 2 },
		},
		workspaces = { laptop = "1-10" },
		-- Monitors no setup configures (e.g. a projector) get this.
		unknown = { mode = "preferred", position = "auto", scale = "auto" },
	},

	options = {
		-- events = { "monitor.added", "monitor.removed", "config.reloaded", "hyprland.start" },
		-- move_existing = true,
		-- default_rule = true,
		-- debounce_ms = 300,
		-- notify = true,
		log = true,
		log_file = "~/.cache/hyprdynamic.log", -- also log to a file that survives reboots
		log_file_max_kb = 1024, -- rotate to <log_file>.1 past this size
		-- move_windows = true, -- on setup change, move open windows to their rule's workspace/monitor
		-- match_mode = "full", -- "full" or "partial" regex matching when moving windows
		-- settle_ms = 100, -- wait after moving workspaces before fixing what each monitor shows
		-- focus_settle_ms = 500, -- focus change counts only if no hotplug follows within this time
		-- guard_max_events = 8, -- pause after this many hotplug events within guard_window_ms (0 = off)
		-- guard_window_ms = 30000,
		-- on_change = function(old, new, ctx) hl.exec_cmd("pkill -SIGUSR2 waybar") end,
	},
})
