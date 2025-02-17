local wezterm = require("wezterm")
local helper = require("helper")

local default_prog

if helper.getOS() == "Windows" then
	default_prog = { "C:\\Program Files\\PowerShell\\7-preview\\pwsh.exe" }
else
	default_prog = { "/bin/zsh", "--login" }
end

return {
	window_decorations = "RESIZE",
	tab_bar_at_bottom = true,
	set_environment_variables = { XDG_CONFIG_HOME = "C:\\Users\\franc\\.config" },
	color_scheme = "Custom",
	default_prog = default_prog,
	colors = {
		cursor_bg = "#f1afd0",
		-- This sets the background color to '#22222'
		background = "#222222",
		-- This sets the default text color to '#f1AFd0'
		foreground = "#f5f5f5",
	},
	-- This sets the background image with 80% opacity
	window_background_image = wezterm.home_dir .. "/theme/garaje-transparent.png",
	-- window_background_opacity = 0.99,
	-- Specify the font here
	font = wezterm.font_with_fallback({ "BlexMono Nerd Font", "" }),
	keys = {
		{
			key = "v",
			mods = "ALT|SHIFT",
			action = wezterm.action({ SplitVertical = { domain = "CurrentPaneDomain" } }),
		},
		{
			key = "h",
			mods = "ALT|SHIFT",
			action = wezterm.action({ SplitHorizontal = { domain = "CurrentPaneDomain" } }),
		},
		{
			key = "=",
			mods = "CTRL",
			action = wezterm.action.DisableDefaultAssignment,
		},
		{
			key = "_",
			mods = "CTRL",
			action = wezterm.action.DisableDefaultAssignment,
		},
		{
			key = "-",
			mods = "CTRL",
			action = wezterm.action.DisableDefaultAssignment,
		},
		{
			key = "+",
			mods = "CTRL",
			action = wezterm.action.DisableDefaultAssignment,
		},
	},
}
