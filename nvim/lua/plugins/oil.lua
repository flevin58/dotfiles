--
-- A vim-vinegar like file explorer that lets you edit your filesystem like a normal Neovim buffer.
--
vim.pack.add({
	{
	    src = "https://github.com/stevearc/oil.nvim.git",
	    name = "oil",
	}
})

vim.pack.add({
	{
	    src = "https://github.com/echasnovski/mini.icons.git",
	    name = "mini-icons",
	}
})

vim.keymap.set("n", "-", "<CMD>Oil --float<CR>", { desc = "Open parent directory" })

require("mini.icons").setup({})

require("oil").setup({
	view_options = {
		show_hidden = true,
	},
	-- Optional dependencies
	dependencies = { { "echasnovski/mini.icons", opts = {} } },
	-- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
	-- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
	lazy = false,
})
