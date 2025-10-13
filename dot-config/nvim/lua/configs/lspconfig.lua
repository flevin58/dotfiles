require("nvchad.configs.lspconfig").defaults()

local lspconfig = require "lspconfig"

local servers = { "html", "cssls", "gopls", "rust-analyzer" }
local nvlsp = require "nvchad.configs.lspconfig"

for _,lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  }
end
-- vim.lsp.enable(servers)

-- read :h vim.lsp.config for changing options of lsp servers
