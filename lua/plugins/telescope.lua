-- telescope
local map = vim.keymap.set

return {
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    opts = function()

      return {
        defaults = {
          prompt_prefix = "   ",
          selection_caret = " ",
          entry_prefix = " ",
          sorting_strategy = "ascending",
          layout_config = {
            horizontal = {
              prompt_position = "bottom",
              preview_width = 0.55,
            },
            width = 0.87,
            height = 0.80,
          },
          mappings = {
            n = { ["q"] = require("telescope.actions").close },
          },
        },
      }
    end,

    keys = {
      { "<leader>fw", "<cmd>Telescope live_grep<CR>", desc = "Telescope live grep" },
      { "<leader>fb", "<cmd>Telescope buffers<CR>", desc = "Telescope find buffers" },
      { "<leader>fh", "<cmd>Telescope help_tags<CR>", desc = "Telescope help page" },
      { "<leader>ma", "<cmd>Telescope marks<CR>", desc = "Telescope find marks" },
      { "<leader>fo", "<cmd>Telescope oldfiles<CR>", desc = "Telescope find oldfiles" },
      { "<leader>fz", "<cmd>Telescope current_buffer_fuzzy_find<CR>", desc = "Telescope find in current buffer" },
      { "<leader>cm", "<cmd>Telescope git_commits<CR>", desc = "Telescope git commits" },
      { "<leader>gt", "<cmd>Telescope git_status<CR>", desc = "Telescope git status" },
      {
        "<leader>cn",
        "<cmd>edit $MYVIMRC <CR> <cmd>cd " .. vim.fn.stdpath "config" .. " <CR>",
        desc = "Telescope open config",
      },
      { "<leader>ff", "<cmd>Telescope find_files<CR>", desc = "Telescope find files" },
      {
        "<leader>fa",
        "<cmd>Telescope find_files follow=true no_ignore=true hidden=true<CR>",
        desc = "Telescope find all files",
      },
    },
  },
}
