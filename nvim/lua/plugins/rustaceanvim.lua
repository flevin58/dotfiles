--
-- Handy plugin to work in rust
--
vim.pack.add({
    {
        src = "https://github.com/mrcjkb/rustaceanvim.git",
        name = "rustaceanvim",
        version = "main",
    },
})

require("rustaceanvim").setup({
    lazy = false,
    ["rust-analyzer"] = {
        cargo = {
            allFeatures = true,
        },
        check = {
            command = "clippy",
        },
        diagnostics = {
            enable = true,
        }
    },
})
