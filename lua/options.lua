
-- UI
vim.wo.number = true
vim.wo.relativenumber = true
vim.o.undofile = true
vim.o.termguicolors = true
vim.o.cursorline = true

-- Editing
vim.o.expandtab = true
vim.o.shiftwidth = 2
vim.o.tabstop = 2
vim.o.smartindent = true
vim.o.autoindent = true
vim.o.wrap = false

-- Search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Misc
vim.o.mouse = "a"
vim.o.splitright = true
vim.o.splitbelow = true

-- Set system clipboard
vim.opt.clipboard = { "unnamed", "unnamedplus" }

vim.cmd("colorscheme catppuccin_mocha")
