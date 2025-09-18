--
-- Conform formats the file on save.
-- Different formatters can be configured (see setup below)
--
vim.pack.add({
	{
		src = "https://github.com/stevearc/conform.nvim.git",
		name = "conform",
	},
})

require("conform").setup({
	formatters_by_ft = {
		go = { "gofmt" },
		lua = { "stylua" },
		rust = { "rustfmt" },
		zig = { "zigfmt" },
		-- css = { "prettier" },
		-- html = { "prettier" },
	},

	format_on_save = {
		-- These options will be passed to conform.format()
		timeout_ms = 500,
		lsp_fallback = true,
	},
})
