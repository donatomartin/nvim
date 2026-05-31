vim.pack.add({
  "https://github.com/nvim-telescope/telescope.nvim",
  "https://github.com/nvim-telescope/telescope-fzf-native.nvim",
  "https://github.com/nvim-telescope/telescope-live-grep-args.nvim",
})

local fzf_path = vim.fn.stdpath("data")
    .. "/site/pack/core/opt/telescope-fzf-native.nvim"

local lib = fzf_path .. "/build/libfzf.so"

-- if not built yet, build it
if vim.fn.filereadable(lib) == 0 then
  if vim.fn.executable("make") == 1 then
    vim.notify("Building telescope-fzf-native.nvim...")

    local result = vim.system({ "make" }, { cwd = fzf_path }):wait()

    if result.code ~= 0 then
      vim.notify(
        "fzf-native build failed:\n" .. (result.stderr or ""),
        vim.log.levels.ERROR
      )
    else
      vim.notify("fzf-native built successfully")
    end
  else
    vim.notify("make not found, cannot build fzf-native", vim.log.levels.WARN)
  end
end

local opts = {
  defaults = {
    prompt_prefix = "   ",
    selection_caret = " ",
    entry_prefix = " ",
    sorting_strategy = "ascending",
    path_display = { "truncate" },
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
  extensions = {
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = "smart_case",
    },
  },
}

local telescope = require "telescope"
telescope.setup(opts)
telescope.load_extension("fzf")

local utils = require "utils"

utils.enableMappings({
  {
    "<leader>ff",
    function()
      require("telescope.builtin").find_files({
        find_command = {
          "fd",
          "--type=f",
          "--hidden",
          "--no-ignore",
          "--exclude",
          ".git",
          "--exclude",
          "node_modules",
          "--exclude",
          "target",
          "--exclude",
          "bin",
          "--exclude",
          "dist",
          "--exclude",
          "coverage",
        },
      })
    end,
    desc = "Find files with fd",
  },
  {
    "<leader>fw",
    function()
      require('telescope').extensions.live_grep_args.live_grep_args()
    end,
    desc = "Telescope find in current buffer"
  },
  { "<leader>fb", "<cmd>Telescope buffers<cr>",                   desc = "Telescope find buffers" },
  { "<leader>fh", "<cmd>Telescope help_tags<cr>",                 desc = "Telescope help page" },
  { "<leader>ma", "<cmd>Telescope marks<cr>",                     desc = "Telescope find marks" },
  { "<leader>fo", "<cmd>Telescope oldfiles<cr>",                  desc = "Telescope find oldfiles" },
  { "<leader>fz", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Telescope find in current buffer" },
  { "<leader>cm", "<cmd>Telescope git_commits<cr>",               desc = "Telescope git commits" },
  { "<leader>fg", "<cmd>Telescope git_status<cr>",                desc = "Telescope git status" },
})
