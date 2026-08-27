-- Colors
vim.opt.background = "dark"
vim.cmd([[colorscheme tokyonight-moon]])

-- Show absolute line numbers
vim.opt.number = true
vim.opt.relativenumber = false
vim.api.nvim_set_hl(0, "LineNr", { fg = "green" })
vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "green" })

vim.opt.swapfile = false -- Don't use swapfile
vim.opt.clipboard = "unnamedplus" -- Use the system clipboard for yank and paste
vim.opt.autoread = true -- Reload files changed outside of Neovim

-- Indentation
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

-- Search
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.ignorecase = true -- Ignore case letters when search

-- windows
vim.opt.splitright = true -- split window to the right
