------------------
---- MONITORS ----
------------------

-- See https://wiki.hypr.land/Configuring/Basics/Monitors/

hl.monitor({
	output = "desc:LG Electronics LG ULTRAGEAR 106NTQD8W884",
	mode = "3440x1440@85",
	position = "2560x160",
	scale = "1",
})

hl.monitor({
	output = "desc:Lenovo Group Limited 0x4146",
	mode = "3840x2400@60",
	position = "0x0",
	scale = "1.5",
	-- disabled = true,
})

hl.monitor({
	output = "desc:Dell Inc. DELL U2722DE 78ML9H3",
	mode = "2560x1440@60",
	position = "1920x0",
	scale = "1",
})

hl.monitor({
	output = "desc:Dell Inc. DELL U2722DE 4M6LV83",
	mode = "2560x1440@60",
	position = "4480x0",
	scale = "1",
})

hl.monitor({
	output = "",
	mode = "preferred",
	position = "auto",
	scale = "auto",
})
