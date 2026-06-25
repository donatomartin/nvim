vim.pack.add({
  "https://github.com/antosha417/nvim-lsp-file-operations",
  "https://github.com/stevearc/oil.nvim",
})

local utils = require("utils")
local oil = require("oil")

oil.setup({
  default_file_explorer = true,
  delete_to_trash = true,
  skip_confirm_for_simple_edits = true,
  view_options = {
    show_hidden = true,
    natural_order = true,
    is_always_hidden = function(name, _)
      return name == '..' or name == '.git'
    end,
  },
  keymaps = {
    ["<esc>"] = { "actions.close", mode = "n" },
  },
  win_options = {
    wrap = false,
    signcolumn = "yes",
    cursorcolumn = true,
  },
  float = {
    border = "rounded",
  }
})

utils.enableMappings({
  { "<leader>oo", oil.toggle_float, desc = "Oil Toggle Float" }
})
