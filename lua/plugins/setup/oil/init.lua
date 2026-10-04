vim.pack.add({
  "https://github.com/stevearc/oil.nvim",
})

local oil = require("oil")
local select = require("plugins.setup.oil.utils").select
local close_oil = require("plugins.setup.oil.utils").close_oil
local toggle_oil_sidebar = require("plugins.setup.oil.utils").toggle_oil_sidebar

oil.setup({
  lsp_file_methods = {
    timeout_ms = 2000,
    autosave_changes = false, 
  },
  default_file_explorer = true,
  delete_to_trash = true,
  skip_confirm_for_simple_edits = true,

  view_options = {
    show_hidden = true,
    natural_order = true,

    is_always_hidden = function(name, _)
      return name == ".." or name == ".git"
    end,
  },

  keymaps = {
    ["<CR>"] = select,
    ["+"] = select,

    ["q"] = {
      callback = close_oil,
      mode = "n",
      desc = "Close Oil",
    },
    ["<leader>e"] = "actions.close",
    ["<leader>o"] = "actions.close",

    ["<C-l>"] = false,
    ["<C-h>"] = false,
    ["<C-t>"] = false,
    ["<C-p>"] = false,

    ["<C-r>"] = "actions.refresh",
    ["<M-i>"] = "actions.toggle_hidden",
    ["<M-t>"] = "actions.toggle_trash",
  },

  win_options = {
    wrap = false,
    signcolumn = "yes",
    cursorcolumn = true,
  },
})

require("utils").enableMappings({
  {
    "<leader>oo",
    function()
      oil.open()
    end,
    desc = "Oil Open",
  },
  {
    "<M-e>",
    toggle_oil_sidebar,
    desc = "Oil Toggle Sidebar",
  },
})
