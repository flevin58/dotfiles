--
-- Minimal and fast statusline module with opinionated default look.
--
vim.pack.add({
	{
		src = "https://github.com/nvim-mini/mini.statusline.git",
		name = "mini-statusline",
	},
})

require("mini.statusline").setup({
	opts = {},
})
