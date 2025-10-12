return {
  -- Adding rust language support
  {
    'mrcjkb/rustaceanvim',
    version = '^6', -- Recommended
    lazy = false, -- This plugin is already lazy
    ft = 'rust',
  },
  -- Adding rust auto-formatting on save
  {
   'rust-lang/rust.vim',
   ft = 'rust',
   init = function()
     vim.g.rustfmt_autosave = 1
   end
  },
  -- Adding rust crates checking
  {
    'saecki/crates.nvim',
    ft = { 'toml' },
    config = function()
      require('crates').setup()
    end,
  },
}
