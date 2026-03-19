
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
vim.o.pumheight = 10

-- Set system clipboard
vim.opt.clipboard = { "unnamed", "unnamedplus" }
if vim.fn.has("wsl") == 1 then
  local win32yank = "/mnt/c/Windows/System32/win32yank.exe"
  if vim.fn.executable(win32yank) == 1 then
    vim.g.clipboard = {
      name = "win32yank (WSL)",
      copy = {
        ["+"] = { win32yank, "-i", "--crlf"},
        ["*"] = { win32yank, "-i", "--crlf"},
      },
      paste = {
        ["+"] = { win32yank, "-o", "--lf"},
        ["*"] = { win32yank, "-o", "--lf"},
      },
      cache_enabled = 0,
    }
  end
end


vim.cmd("colorscheme catppuccin_mocha")
