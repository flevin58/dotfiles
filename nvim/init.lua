--
-- Define Leader keys
--

vim.g.mapleader = " "
vim.g.maplocalleader = ";"

--
-- Load configuration files
--
require("config.autocmds")
require("config.diagnostics")
require("config.keymaps")
require("config.options")

--
-- Load plugins
--
require("plugins.conform")
require("plugins.kanagawa")
require("plugins.lspconfig")
require("plugins.mini-starter")
require("plugins.mini-statusline")
require("plugins.noice")
require("plugins.oil")
require("plugins.showkeys")
require("plugins.sleuth")
require("plugins.which-key")
