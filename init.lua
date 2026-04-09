-- Define leader key
vim.g.mapleader = " "
vim.g.maplocalleader = ","

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

-- load plugins
if not vim.g.vscode then
  require("lazy").setup({
    { import = "plugins" },
    { import = "plugins/shared" },
  })
else
  require("lazy").setup({
    { import = "plugins/shared" },
  })
end

require "options"
require "autocmds"
require "mappings"
