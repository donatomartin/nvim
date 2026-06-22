vim.pack.add({
  "https://github.com/antosha417/nvim-lsp-file-operations",
  "https://github.com/stevearc/oil.nvim",
})

require("oil").setup({
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
  win_options = {
    wrap = true,
  }
})

vim.keymap.set("n", "<leader>oo", require("oil").toggle_float)
