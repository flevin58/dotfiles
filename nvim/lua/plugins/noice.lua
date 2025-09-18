--
-- Highly experimental plugin that completely replaces the UI for messages, cmdline and the popupmenu.
--
vim.pack.add({
	{
		src = "https://github.com/folke/noice.nvim.git",
		name = "noice",
	}
})

--
-- Add some dependencies
--
vim.pack.add({
	{
		src = "https://github.com/MunifTanjim/nui.nvim.git",
		name = "nui",
	}
})

vim.pack.add({
	{
		src = "https://github.com/rcarriga/nvim-notify.git",
		name = "nvim-notify",
	}
})

require('noice').setup({
		{
		"folke/noice.nvim",
		event = "VeryLazy",
		opts = {
			-- Add any options here
		},
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		}
	}
})

