vim.opt.expandtab = false     -- Convert tabs to spaces when true
vim.opt.shiftwidth = 4        -- Amount to indent with << and >>
vim.opt.tabstop = 4           -- How many spaces are shown per tab
vim.opt.softtabstop = 4       -- How many spaces are applied when pressing Tab

vim.opt.smarttab = true       -- Vim will be aware of the indentations and will let you delete them with one keystroke
vim.opt.smartindent = true
vim.opt.autoindent = true     -- Keep indentation from previous line
vim.opt.breakindent = true    -- How it renders the line when longer than the buffer width

vim.opt.number = true         -- Show line numbers
vim.opt.relativenumber = true -- Line numbers are relative except for the current line
vim.opt.signcolumn = "yes"    -- Keeps space to the left of the line number for any letters (W warn, E err, etc.)

vim.opt.cursorline = true     -- Show line under cursor

vim.opt.undofile = true       -- Keep undos between sessions

vim.opt.mouse = "a"           -- Enable mouse mode (e.g. for resizing splits)

vim.opt.showmode = false      -- Not needed because it is shown in the status line

vim.opt.ignorecase = true     -- Case insensitive search
vim.opt.smartcase = true

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Set how neovim will display certain characters
vim.opt.list = true
vim.opt.listchars = {
	tab = "» ",
	trail = "·",
	nbsp = "␣",
	extends = "…",
}

vim.opt.scrolloff = 5 -- Minimal number of screen lines to keep above and below the cursor

vim.opt.winborder = "rounded"
