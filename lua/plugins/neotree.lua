vim.pack.add({
  "https://github.com/MunifTanjim/nui.nvim",
  "https://github.com/nvim-tree/nvim-web-devicons",
  "https://github.com/antosha417/nvim-lsp-file-operations",
  "https://github.com/nvim-neo-tree/neo-tree.nvim",
})

require("lsp-file-operations").setup()
require "neo-tree".setup({
  close_if_last_window = true,
  filesystem = {
    hijack_netrw_behavior = "disabled",
    follow_current_file = { enabled = true, leave_dirs_open = false },
  },
  window = {
    width = 30,
    mappings = {
      ["l"] = "open",
      ["h"] = "close_node",
    },
  },
})

vim.keymap.set("n",
  "<leader>n",
  "<cmd>Neotree toggle reveal_force_cwd<cr>",
  {
    silent = true,
    desc = "Toggle Neo-tree",
  }
)

-- Auto-close Neo-tree before exit so sessions stay clean
vim.api.nvim_create_autocmd("VimLeavePre", {
  callback = function()
    pcall(vim.cmd, "Neotree close")
  end,
})
