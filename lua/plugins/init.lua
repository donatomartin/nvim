-- Zero Setup Plugins
vim.pack.add({
  -- Default lsp configurations
  "https://github.com/neovim/nvim-lspconfig",
  -- Utils library
  "https://github.com/nvim-lua/plenary.nvim",
  -- Surround movements
  "https://github.com/tpope/vim-surround",
  -- Zoxide integration
  "https://github.com/nanotee/zoxide.vim",
  -- Icons
  "https://github.com/nvim-tree/nvim-web-devicons",
  -- Fugitive
 "https://github.com/tpope/vim-fugitive",
})

-- Plugin Configurations
require "plugins/oil"
require "plugins/tmux"
require "plugins/mason"
require "plugins/catppuccin"
require "plugins/autopairs"
require "plugins/gitsigns"
require "plugins/harpoon"
require "plugins/sonarlint"
require "plugins/jdtls"
require "plugins/whichkey"
require "plugins/lualine"
require "plugins/lint"
require "plugins/neotab"
require "plugins/opencode"
require "plugins/texpresso"
require "plugins/snacks"
require "plugins/cmp"
require "plugins/minimap"

