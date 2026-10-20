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

  -- Abolish
  "https://github.com/tpope/vim-abolish",

  -- Autopairs
  "https://github.com/windwp/nvim-autopairs",
  "https://github.com/catppuccin/nvim",

  -- Completion
  "https://github.com/hrsh7th/nvim-cmp",
  "https://github.com/hrsh7th/cmp-nvim-lsp",
  "https://github.com/hrsh7th/cmp-buffer",
  "https://github.com/hrsh7th/cmp-path",
  "https://github.com/hrsh7th/cmp-cmdline",
  "https://github.com/saadparwaiz1/cmp_luasnip",
  "https://github.com/L3MON4D3/LuaSnip",
  "https://github.com/rafamadriz/friendly-snippets",

  -- Debugger
  "https://codeberg.org/mfussenegger/nvim-dap",
  "https://github.com/rcarriga/nvim-dap-ui",
  "https://github.com/nvim-neotest/nvim-nio",

  -- Terminals
  "https://github.com/donatomartin/floaterm", -- personal fork that enables current buffer name modification
  "https://github.com/nvzone/volt",

  -- Git
  "https://github.com/lewis6991/gitsigns.nvim",
  "https://github.com/neogitorg/neogit",
  "https://github.com/tpope/vim-fugitive",

  -- Tab
  "https://github.com/kawre/neotab.nvim",

  -- Lint
  "https://github.com/mfussenegger/nvim-lint",

  -- Lualine
  'https://github.com/nvim-lualine/lualine.nvim',

  -- Mason
  "https://github.com/williamboman/mason.nvim",
  "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim",

  -- Minimap
  "https://github.com/Isrothy/neominimap.nvim",

  -- Opencode
  "https://github.com/nickjvandyke/opencode.nvim",

  -- Sonar
  "https://gitlab.com/schrieveslaach/sonarlint.nvim",

  -- Texpresso
  "https://github.com/let-def/texpresso.vim",

  -- Snacks
  "https://github.com/folke/snacks.nvim",

  -- Which key
  "https://github.com/folke/which-key.nvim",

  -- Tmux
  "https://github.com/christoomey/vim-tmux-navigator",
  "https://github.com/RyanMillerC/better-vim-tmux-resizer",

  -- Zen
  "https://github.com/folke/zen-mode.nvim",

  -- Jdtls
  "https://github.com/mfussenegger/nvim-jdtls",

  -- Comment Box
  "https://github.com/ludopinelli/comment-box.nvim"

})

require "plugins.setup.init"
