local wezterm = require("wezterm")

return {
	window_decorations = "RESIZE",
	tab_bar_at_bottom = true,
	color_scheme = "Custom",
	default_prog = { "C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" },
	colors = {
		cursor_bg = "#f1afd0",
		-- This sets the background color to '#22222'
		background = "#222222",
		-- This sets the default text color to '#f1AFd0'
		foreground = "#f5f5f5",
	},
	-- This sets the background image with 80% opacity
	window_background_image = wezterm.home_dir .. "/theme/garaje-transparent.png",
	window_background_opacity = 0.97,
	-- Specify the font here
	font = wezterm.font("BlexMono Nerd Font"),
	keys = {
		-- This will split the current pane vertically with Ctrl+Shift+V
		{
			key = "%", -- Uppercase 'V' indicates that Shift is being held
			mods = "CTRL|SHIFT",
			action = wezterm.action({ SplitVertical = { domain = "CurrentPaneDomain" } }),
		},
		-- This will split the current pane horizontally with Ctrl+Shift+V
		{
			key = "$", -- Uppercase 'V' indicates that Shift is being held
			mods = "CTRL|SHIFT",
			action = wezterm.action({ SplitHorizontal = { domain = "CurrentPaneDomain" } }),
		},
	},
}
