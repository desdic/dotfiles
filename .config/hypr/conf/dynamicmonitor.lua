local function get_monitor_name_by_description(target_desc)
	local monitors = hl.get_monitors()

	for _, mon in ipairs(monitors) do
		if mon.description and string.find(mon.description, target_desc) then
			return mon.name
		end
	end

	return "eDP-1"
end

local function identify_setup()
	local mon = hl.get_monitors()

	for _, m in ipairs(mon) do
		if m.description == "LG Electronics LG ULTRAGEAR 106NTQD8W884" then
			return function()
				local target_monitor = get_monitor_name_by_description("LG Electronics LG ULTRAGEAR 106NTQD8W884")
				for i = 1, 5 do
					hl.dispatch(hl.dsp.workspace.move({
						workspace = i,
						monitor = target_monitor,
					}))

					hl.workspace_rule({ workspace = tostring(i), monitor = target_monitor, default = true })
				end
				hl.monitor({
					output = "desc:Lenovo Group Limited 0x4146",
					mode = "3840x2400@60",
					position = "0x0",
					scale = "1.5",
					-- disabled = true,
				})

				hl.monitor({
					output = "desc:LG Electronics LG ULTRAGEAR 106NTQD8W884",
					mode = "3440x1440@85",
					position = "2560x160",
					scale = "1",
				})
				local laptop_monitor = get_monitor_name_by_description("Lenovo Group Limited 0x4146")
				hl.workspace_rule({ workspace = "8", monitor = laptop_monitor, default = true })
			end
		end
		if m.description == "Dell Inc. DELL U2722DE 78ML9H3" then
			return function()
				local left = get_monitor_name_by_description("Dell Inc. DELL U2722DE 78ML9H3")
				local right = get_monitor_name_by_description("Dell Inc. DELL U2722DE 4M6LV83")
				for i = 1, 3 do
					hl.dispatch(hl.dsp.workspace.move({ workspace = i, monitor = left }))
					hl.workspace_rule({ workspace = tostring(i), monitor = left, default = true })
				end
				for i = 4, 5 do
					hl.dispatch(hl.dsp.workspace.move({ workspace = i, monitor = right }))
					hl.workspace_rule({ workspace = tostring(i), monitor = right, default = true })
				end

				hl.monitor({
					output = "desc:Lenovo Group Limited 0x4146",
					mode = "3840x2400@60",
					position = "0x1440",
					scale = "1.5",
				})

				local laptop_monitor = get_monitor_name_by_description("Lenovo Group Limited 0x4146")
				hl.workspace_rule({ workspace = "8", monitor = laptop_monitor, default = true })

				hl.monitor({
					output = "desc:Dell Inc. DELL U2722DE 78ML9H3",
					mode = "2560x1440@60",
					position = "0x0",
					scale = "1",
				})

				hl.monitor({
					output = "desc:Dell Inc. DELL U2722DE 4M6LV83",
					mode = "2560x1440@60",
					position = "2560x0",
					scale = "1",
				})
			end
		end
	end

	return function()
		for i = 1, 10 do
			hl.dispatch(hl.dsp.workspace.move({ workspace = i, monitor = "eDP-1" }))
		end

		hl.monitor({
			output = "desc:Lenovo Group Limited 0x4146",
			mode = "3840x2400@60",
			position = "auto",
			scale = "2",
		})
	end
end

local function dynamic_monitors()
	local location = identify_setup()
	location()
end

local events = { "monitor.added", "monitor.removed", "config.reloaded", "hyprland.start" }
for _, event in ipairs(events) do
	hl.on(event, function(_)
		dynamic_monitors()
	end)
end

dynamic_monitors()
