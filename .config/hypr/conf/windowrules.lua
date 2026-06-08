-- Ref https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/

hl.window_rule({
	name = "mumble",
	match = {
		class = "info.mumble.Mumble",
	},
	workspace = 1,
})

hl.window_rule({
	name = "dino",
	match = {
		class = "im.dino.Dino",
	},
	workspace = 1,
})

hl.window_rule({
	name = "tmux",
	match = {
		class = "tmux",
	},
	workspace = 3,
})

hl.window_rule({
	name = "chromium",
	match = {
		class = "chromium",
	},
	workspace = 4,
})

hl.window_rule({
	name = "google-chrome",
	match = {
		class = "google-chrome",
	},
	workspace = 4,
})

hl.window_rule({
	name = "Spotify",
	match = {
		class = "Spotify",
	},
	workspace = 5,
})
