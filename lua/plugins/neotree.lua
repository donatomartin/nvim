return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    lazy = false,
    keys = {
      {
        "<leader>n",
        "<cmd>Neotree toggle reveal_force_cwd<CR>",
        mode = "n",
        silent = true,
        desc = "Toggle Neo-tree",
      },
    },
    config = function(_, _)
      require("neo-tree").setup({
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

      -- Auto-close Neo-tree before exit so sessions stay clean
      vim.api.nvim_create_autocmd("VimLeavePre", {
        callback = function()
          pcall(vim.cmd, "Neotree close")
        end,
      })
    end,
  },
}
