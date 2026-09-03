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
	no_initial_focus = true,
})

hl.window_rule({
	name = "tmux",
	match = {
		class = "tmux",
	},
	workspace = 3,
})

hl.window_rule({
	name = "herdr",
	match = {
		class = "herdr",
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
	no_initial_focus = true,
})

hl.window_rule({
	name = "spotify",
	match = {
		class = "spotify",
	},
	workspace = 5,
	no_initial_focus = true,
})

hl.window_rule({
	match = { class = "dev.noctalia.Noctalia" },
	float = true,
	size = { 1080, 920 },
})

-- Bitwardens plugin popup initial title
hl.window_rule({
	match = { title = "_crx_nngceckbapebfimnlniiiahkandclblb" },
	float = true,
	size = { 400, 600 },
})

hl.layer_rule({
	name = "noctalia",
	match = {
		namespace = "^noctalia-(bar-.+|notification|dock|panel|attached-panel|osd)$",
	},
	no_anim = true,
	ignore_alpha = 0.5,
	blur = true,
	blur_popups = true,
})
