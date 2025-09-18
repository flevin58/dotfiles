--
-- NeoVim dark colorscheme inspired by the colors of the famous painting by Katsushika Hokusai.
--
vim.pack.add({
	{
		src = "https://github.com/rebelot/kanagawa.nvim.git",
		name = "kanagawa",
	},
})

require("kanagawa").setup({
	compile = true,
	transparent = true,
	overrides = function(colors)
		return {
			["@markup.link.url.markdown_inline"] = { link = "Special" }, -- (url)
			["@markup.link.label.markdown_inline"] = { link = "WarningMsg" }, -- [label]
			["@markup.italic.markdown_inline"] = { link = "Exception" }, -- *italic*
			["@markup.raw.markdown_inline"] = { link = "String" },   -- `code`
			["@markup.list.markdown"] = { link = "Function" },       -- + list
			["@markup.quote.markdown"] = { link = "Error" },         -- blockcode
			["@markup.list.checked.markdown"] = { link = "WarningMsg" }, -- [X] checked list
		}
	end,
})

vim.cmd("colorscheme kanagawa")

build = function()
	vim.cmd("KanagawaCompile")
end
