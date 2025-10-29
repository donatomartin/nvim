return {
  {
    "lewis6991/gitsigns.nvim",
    lazy = false, -- ensure it loads immediately
    config = function()
      require("gitsigns").setup({
        signs = {
          add          = { text = "│", hl = "GitSignsAdd" },
          change       = { text = "│", hl = "GitSignsChange" },
          delete       = { text = "󰍵", hl = "GitSignsDelete" },
          topdelete    = { text = "󰍵", hl = "GitSignsDelete" },
          changedelete = { text = "󰍵", hl = "GitSignsChange" },
          untracked    = { text = "│", hl = "GitSignsAdd" },
        },
        signcolumn = true,
        numhl = false,
        linehl = false,
        word_diff = false,

        -- current_line_blame = true,
        -- current_line_blame_opts = {
        --   virt_text = true,
        --   virt_text_pos = "eol",
        --   delay = 300,
        -- },
        -- current_line_blame_formatter = "  <author>, <author_time:%R> • <summary>",
      })
    end,
    keys = {
      { "<leader>gdh", "<cmd>Gitsigns diffthis HEAD<CR>" },
      { "<leader>gdd", "<cmd>Gitsigns preview_hunk_inline<CR>" },
      { "<leader>gdD", "<cmd>Gitsigns diffthis<CR>" },
      { "<leader>gds", "<cmd>Gitsigns diffthis --staged<CR>" },
      { "<leader>gs", "<cmd>Gitsigns stage_hunk<CR>" },
      { "<leader>gb", "<cmd>Gitsigns blame_line<CR>" },
      { "<leader>gn", "<cmd>Gitsigns next_hunk<CR>" },
      { "<leader>gp", "<cmd>Gitsigns prev_hunk<CR>" },
      { "<leader>grh", "<cmd>Gitsigns reset_hunk<CR>" },
      { "<leader>grb", "<cmd>Gitsigns reset_buffer<CR>" },
    },
  },

  {
    "tpope/vim-fugitive",
    cmd = { "Git", "G", "Gdiffsplit", "Gvdiffsplit" },
  },
}
