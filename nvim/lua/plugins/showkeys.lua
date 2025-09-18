--
-- Eye-candy keys screencaster for Neovim
--
vim.pack.add({
	{
		src = "https://github.com/nvzone/showkeys.git",
		name = "show-keys",
	}
})

require("showkeys").setup({
	cmd = "ShowkeysToggle",
	opts = {
		timeout = 1,
		maxkeys = 5
	}
})
