-------------------
---- AUTOSTART ----
-------------------

-- See https://wiki.hypr.land/Configuring/Basics/Autostart/

-- Autostart necessary processes (like notifications daemons, status bars, etc.)
-- Or execute your favorite apps at launch like this:
--
hl.on("hyprland.start", function()
	hl.exec_cmd("gsettings set org.gnome.desktop.interface gtk-enable-primary-paste true")
	hl.exec_cmd("qs -c noctalia-shell")
	hl.exec_cmd("[workspace 1 silent] /usr/bin/dino")
	hl.exec_cmd("[workspace 5 silent] /sbin/spotify --enable-features=UseOzonePlatform --ozone-platform=wayland")
	hl.exec_cmd("/usr/bin/hypridle")
	hl.exec_cmd(
		'/sbin/kitty --app-id=tmux --directory "$HOME/git/chef-repo" tmux new-session -A -s chef-repo',
		{ workspace = 3 }
	)
end)
