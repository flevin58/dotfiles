vim.pack.add({
	{ src = "https://github.com/neovim/nvim-lspconfig" },
})

--
-- Attach the LSP client when vim starts
--
vim.api.nvim_create_autocmd("LspAttach", {
	desc = "Attach the LSP client when vim starts",
	group = vim.api.nvim_create_augroup("my.lsp", {}),
	callback = function(args)
		local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
		if client:supports_method("textDocument/completion") then
			vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
		end
	end,
})

vim.cmd("set completeopt+=noselect")

--
-- Enable the language servers in the lsp folder
--
vim.lsp.enable({
	"gopls",
	"lua_ls",
	"rust",
})
