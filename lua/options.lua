-- lua/options.lua

-- NvChad options
local opt = vim.opt
local o = vim.o
local g = vim.g

-- Lua (init.lua)
vim.cmd [[highlight Normal guibg=NONE ctermbg=NONE]]
vim.cmd [[highlight NormalNC guibg=NONE ctermbg=NONE]]
vim.cmd [[highlight EndOfBuffer guibg=NONE ctermbg=NONE]]
-------------------------------------- options ------------------------------------------
o.laststatus = 3
o.showmode = false

o.clipboard = "unnamedplus"
o.cursorline = true
o.cursorlineopt = "number"

-- Indenting
o.expandtab = true
o.shiftwidth = 2
o.smartindent = true
o.tabstop = 2
o.softtabstop = 2

opt.fillchars = { eob = " " }
o.ignorecase = true
o.smartcase = true
o.mouse = "a"

-- Numbers
o.number = true
o.numberwidth = 2
o.ruler = false

-- disable nvim intro
opt.shortmess:append "sI"

o.signcolumn = "yes"
o.splitbelow = true
o.splitright = true
o.timeoutlen = 400
o.undofile = true

-- interval for writing swap file to disk, also used by gitsigns
o.updatetime = 250

-- go to previous/next line with h,l,left arrow and right arrow
-- when cursor reaches end/beginning of line
opt.whichwrap:append "<>[]hl"

-- disable some default providers
g.loaded_node_provider = 0
g.loaded_python3_provider = 0
g.loaded_perl_provider = 0
g.loaded_ruby_provider = 0

-- add binaries installed by mason.nvim to path
local is_windows = vim.fn.has "win32" ~= 0
local sep = is_windows and "\\" or "/"
local delim = is_windows and ";" or ":"
vim.env.PATH = table.concat({ vim.fn.stdpath "data", "mason", "bin" }, sep) .. delim .. vim.env.PATH

-- terminal options
vim.opt.shell = is_windows and "pwsh" or "zsh"
vim.opt.shellcmdflag = is_windows and "-nologo -noprofile -ExecutionPolicy RemoteSigned -command" or "-c"
vim.opt.shellxquote = ""

vim.api.nvim_create_autocmd("TermOpen", {
  pattern = "*",
  callback = function()
    vim.wo.number = false
    vim.wo.relativenumber = false
  end,
})

-- other options
vim.o.relativenumber = true
vim.o.number = true
