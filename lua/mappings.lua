local function copy_current_path(modifier)
  local value = vim.fn.expand("%" .. modifier)
  vim.fn.setreg("+", value)
  print("Copied: " .. value)
end

local function clearHighlight()
  vim.cmd("noh")
  vim.cmd("echo ''")
end

local function toggleLines()
  vim.opt_local.number = not vim.opt_local.relativenumber:get()
  vim.opt_local.relativenumber = not vim.opt_local.relativenumber:get()
end

require("utils").enableMappings({
  { "j",          "gj",                                     desc = "Move down by visual line" },
  { "k",          "gk",                                     desc = "Move up by visual line" },
  { "<C-c>",      ":%y+<cr>",                               desc = "Yank file to system clipboard",  mode = { "n", "v" }, },
  { "<leader>j",  "<cmd>b#<cr>",                            desc = "Switch to alternate buffer" },
  { "<F1>",       "",                                       desc = "F1 is disabled",                 mode = { "n", "v", "i", "t" }, },
  { "<Esc><Esc>", "<C-\\><C-N>",                            desc = "Escape terminal mode",           mode = "t", },
  { "<Esc>",      clearHighlight,                           desc = "Clear search highlight" },
  { "<leader>yy", ":%y+<cr>",                               desc = "Yank file to system clipboard",  mode = { "n", "v" }, },
  { "<leader>yf", function() copy_current_path(":t") end,   desc = "Copy filename" },
  { "<leader>yF", function() copy_current_path(":t:r") end, desc = "Copy filename without extension" },
  { "<leader>yp", function() copy_current_path(":p") end,   desc = "Copy full path" },
  { "<leader>yr", function() copy_current_path(":.") end,   desc = "Copy relative path" },
  { "<leader>tr", toggleLines,                              desc = "Toggle Relative Lines" },
})
