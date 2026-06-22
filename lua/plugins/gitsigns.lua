vim.pack.add({
  "https://github.com/lewis6991/gitsigns.nvim"
})

require("gitsigns").setup({
  signs = {
    add = { text = "│", hl = "GitSignsAdd" },
    change = { text = "│", hl = "GitSignsChange" },
    delete = { text = "󰍵", hl = "GitSignsDelete" },
    topdelete = { text = "󰍵", hl = "GitSignsDelete" },
    changedelete = { text = "󰍵", hl = "GitSignsChange" },
    untracked = { text = "│", hl = "GitSignsAdd" },
  },
  signcolumn = true,
  numhl = false,
  linehl = false,
  word_diff = false,

  current_line_blame_formatter = "  <author>, <author_time:%R> • <summary>",
  current_line_blame = true,
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = "eol",
    delay = 300,
  },
})

local utils = require "utils"

utils.enableMappings(
  {
    { "<leader>gdd", function()
      vim.cmd("Gitsigns diffthis")
      vim.cmd("wincmd h");
    end },
    { "<leader>gdh", function()
      vim.cmd("Gitsigns diffthis HEAD")
      vim.cmd("wincmd h");
    end },
    { "<leader>gds", function()
      vim.cmd("Gitsigns diffthis --staged")
      vim.cmd("wincmd h");
    end },
    { "<leader>gdc", function()
      local commit = vim.fn.input("Commit/ref: ")
      if commit == nil or commit == "" then
        return
      end
      vim.cmd("Gitsigns diffthis " .. commit .. " HEAD")
      vim.defer_fn(function() vim.cmd("wincmd h") end, 50)
    end },
    { "<leader>ghs", function() require "gitsigns".stage_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, mode = "v"},
    { "<leader>ghd", "<cmd>Gitsigns preview_hunk_inline<cr>" },
    { "<leader>ghp", "<cmd>Gitsigns preview_hunk_inline<cr>" },
    { "<leader>ghs", "<cmd>Gitsigns stage_hunk<cr>" },
    { "<leader>ghv", "<cmd>Gitsigns select_hunk<cr>" },
    { "<leader>ghr", "<cmd>Gitsigns reset_hunk<cr>" },
    { "<leader>ghn", "<cmd>Gitsigns next_hunk<cr>" },
    { "<leader>ghN", "<cmd>Gitsigns prev_hunk<cr>" },
    { "<leader>glb", "<cmd>Gitsigns blame_line<cr>" },
    { "<leader>gbr", "<cmd>Gitsigns reset_buffer<cr>" },
    { "<leader>gbs", "<cmd>Gitsigns stage_buffer<cr>" },
  }
)
