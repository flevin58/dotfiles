--
-- Wezterm settings
--

local wezterm = require("wezterm")
local config = wezterm.config_builder()

--
-- Font stuff
--
config.font = wezterm.font("FiraCode Nerd Font Mono")
config.font_size = 20
config.line_height = 1.2

--
-- Color stuff
--
--config.color_scheme = "Catppuccin Mocha"
config.color_scheme = "Classic Dark"
config.colors = {
	cursor_bg = "#7aa2f7",
	cursor_border = "#ffffff",
}

--
-- Windows / Tabs stuff
--
config.enable_tab_bar = true
config.hide_tab_bar_if_only_one_tab = true
config.window_background_opacity = 1.0
config.macos_window_background_blur = 8

--
-- Key Bindings
--
config.enable_kitty_keyboard = true
config.send_composed_key_when_left_alt_is_pressed = true
config.leader = {
	key = "z",
	mods = "CTRL",
	timeout_milliseconds = 1000,
}
config.keys = {
	{
		-- Split horizontal
		key = "h",
		mods = "LEADER",
		action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
	{
		-- Split vertical
		key = "v",
		mods = "LEADER",
		action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
	},
	{
		-- Exit pane
		key = "x",
		mods = "LEADER",
		action = wezterm.action.SendString("exit\n"),
	},
	{
		-- Clear screen
		key = "k",
		mods = "LEADER",
		action = wezterm.action.SendString("clear\n"),
	},
}
return config
