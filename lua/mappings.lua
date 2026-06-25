local utils = require("utils")

local function copy_current_path(modifier)
  local value = vim.fn.expand("%" .. modifier)
  vim.fn.setreg("+", value)
  print("Copied: " .. value)
end

local function clearHighlight()
  vim.cmd("noh")
  vim.cmd("echo ''")
end

utils.enableMappings({
  { "j",          "gj",                                     desc = "Move down by visual line" },
  { "k",          "gk",                                     desc = "Move up by visual line" },
  { "<leader>yy", ":%y+<cr>",                               desc = "Yank file to system clipboard",  mode = { "n", "v" }, },
  { "<C-c>",      ":%y+<cr>",                               desc = "Yank file to system clipboard",  mode = { "n", "v" }, },
  { ";",          ":lua ",                                  desc = "Enter Lua command" },
  { "<leader>j",  "<cmd>b#<cr>",                            desc = "Switch to alternate buffer" },
  { "<F1>",       "",                                       desc = "F1 is disabled",                 mode = { "n", "v", "i", "t" }, },
  { "<Esc><Esc>", "<C-\\><C-N>",                            desc = "Escape terminal mode",           mode = "t", },
  { "<Esc>",      clearHighlight,                           desc = "Clear search highlight" },
  { "<leader>yf", function() copy_current_path(":t") end,   desc = "Copy filename" },
  { "<leader>yF", function() copy_current_path(":t:r") end, desc = "Copy filename without extension" },
  { "<leader>yp", function() copy_current_path(":p") end,   desc = "Copy full path" },
  { "<leader>yr", function() copy_current_path(":.") end,   desc = "Copy relative path" },
})
