-- Define leader key
vim.g.mapleader = " "
vim.g.maplocalleader = ","

-- Custom Configurations
require "options"
require "autocmds"
require "mappings"
require "commands"

-- Zero Config Plugins
vim.pack.add({
  "https://github.com/neovim/nvim-lspconfig",
  "https://github.com/nvim-lua/plenary.nvim",
  "https://github.com/tpope/vim-surround",
  "https://github.com/nanotee/zoxide.vim",
  "https://github.com/tpope/vim-fugitive",
  'https://github.com/nvim-tree/nvim-web-devicons',
  "https://github.com/let-def/texpresso.vim",
})

-- Plugin Configurations
require "plugins/tmux"
require "plugins/neotree"
require "plugins/mason"
require "plugins/telescope"
require "plugins/catppuccin"
require "plugins/autopairs"
require "plugins/blink"
require "plugins/gitsigns"
require "plugins/harpoon"
require "plugins/flash"
require "plugins/sonarlint"
require "plugins/jdtls"
require "plugins/whichkey"
require "plugins/lualine"
require "plugins/ibl"
require "plugins/lint"
require "plugins/neotab"

-- Lsp Configurations
require "lang".start()

