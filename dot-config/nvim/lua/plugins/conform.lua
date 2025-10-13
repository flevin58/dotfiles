return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    -- opts = require "configs.conform",
    require('conform').setup({
      formatters_by_ft = {
        lua = { "stylua" },
        html = { "htmlbeautifier" },
        css = { "prettierd", "prettier" },
        bash = { "beautysh" },
        rust = { "rustfmt", lsp_format = "fallback" },
        yaml = { "yamlfix" },
        toml = { "taplo" },
        go = { "gofmt" },
      },
    }),

    vim.keymap.set({ "n", "v" }, "f", function()
      require('conform').format({
        lsp_fallback = true,
        async = false,
        timeout_ms = 1000,
      })
    end, { desc = "Format file or range (in visual mode)" })
  },
}
