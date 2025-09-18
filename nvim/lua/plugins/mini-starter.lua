--
-- Shows a starting page
--
vim.pack.add({
	{
		src = "https://github.com/nvim-mini/mini.starter.git",
		name = "mini-starter",
	},
})

require("mini.starter").setup({
	header = "Nando's Vim Starter Page",
	footer = "Have a nice day 😻",
	items = {
		-- Configurations
		{ action = ":e $DOTFILES", name = "dotfiles settings (navigate all folders)", section = "Configurations" },
		{ action = ":e $DOTFILES/nvim", name = "nvim settings", section = "Configurations" },
		{ action = ":e $DOTFILES/starship/starship.toml", name = "starship settings", section = "Configurations" },
		{ action = ":e $DOTFILES/wezterm/dot_wezterm.lua", name = "wezterm settings", section = "Configurations" },
		{ action = ":e $DOTFILES/zsh", name = "zsh settings", section = "Configurations" },
		-- Projects
		{ action = ":e $PROJECTS", name = "Navigate project folders", section = "Projects" },
	},
})
