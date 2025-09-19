return {
	cmd = { "lua-language-server" },
	filetypes = {
		"lua",
	},
	root_markers = {
		".git",
		".luacheckrc",
		".luarc.json",
		".luarc.jsonc",
		".stylua.toml",
		"selene.toml",
		"selene.yml",
		"stylua.toml",
	},
	single_file_support = true,
	log_level = vim.lsp.protocol.MessageType.Warning,
	settings = {
		Lua = {
			telemetry = {
				enable = false,
			},
		},
	},
	on_init = function(client)
		local join = vim.fs.joinpath
		local path = client.workspace_folders[1].name

		-- Don't do anything if there is project local config
		if vim.uv.fs_stat(join(path, ".luarc.json")) or vim.uv.fs_stat(join(path, ".luarc.jsonc")) then
			return
		end

		local nvim_settings = {
			runtime = {
				-- Tell the language server which version of Lua you're using
				version = "LuaJIT",
			},
			diagnostics = {
				-- Get the language server to recognize the `vim` global
				globals = { "vim" },
			},
			workspace = {
				checkThirdParty = false,
				library = {
					-- Make the server aware of Neovim runtime files
					vim.env.VIMRUNTIME,
					vim.fn.stdpath("config"),
				},
			},
		}

		client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, nvim_settings)
	end,
}
