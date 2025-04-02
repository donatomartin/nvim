-- telescope
local map = vim.keymap.set

map("n", "<leader>fw", "<cmd>Telescope live_grep<CR>", { desc = "telescope live grep" })
map("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { desc = "telescope find buffers" })
map("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", { desc = "telescope help page" })
map("n", "<leader>ma", "<cmd>Telescope marks<CR>", { desc = "telescope find marks" })
map("n", "<leader>fo", "<cmd>Telescope oldfiles<CR>", { desc = "telescope find oldfiles" })
map("n", "<leader>fz", "<cmd>Telescope current_buffer_fuzzy_find<CR>", { desc = "telescope find in current buffer" })
map("n", "<leader>cm", "<cmd>Telescope git_commits<CR>", { desc = "telescope git commits" })
map("n", "<leader>gt", "<cmd>Telescope git_status<CR>", { desc = "telescope git status" })
map("n", "<leader>pt", "<cmd>Telescope terms<CR>", { desc = "telescope pick hidden term" })
map(
  "n",
  "<leader>cn",
  "<cmd>edit $MYVIMRC <CR> <cmd>cd " .. vim.fn.stdpath "config" .. " <CR>",
  { desc = "telescope open config" }
)
map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "telescope find files" })
map(
  "n",
  "<leader>fa",
  "<cmd>Telescope find_files follow=true no_ignore=true hidden=true<CR>",
  { desc = "telescope find all files" }
)

return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    cmd = "Telescope",
    opts = function()
      dofile(vim.g.base46_cache .. "telescope")

      return {
        defaults = {
          prompt_prefix = "   ",
          selection_caret = " ",
          entry_prefix = " ",
          sorting_strategy = "ascending",
          layout_config = {
            horizontal = {
              prompt_position = "top",
              preview_width = 0.55,
            },
            width = 0.87,
            height = 0.80,
          },
          mappings = {
            n = { ["q"] = require("telescope.actions").close },
          },
        },

        extensions_list = { "themes", "terms" },
        extensions = {},
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
      { "<leader>pt", "<cmd>Telescope terms<CR>", desc = "Telescope pick hidden term" },
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
