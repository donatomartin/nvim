local map = vim.keymap.set

map({"n","v"}, "<leader>yy", ":%y+<cr>", { desc = "Yank file to system clipboard" })
map({"n","v"}, "<C-c>", ":%y+<cr>", { desc = "Yank file to system clipboard" })
map("n", ";", ":lua ")
map("n", "<leader>j", "<cmd>b#<cr>")
map({"n", "v", "i", "t"}, "<F1>", "", { desc = "F1 is disabled" })
map("t", "<Esc><Esc>", "<C-\\><C-N>", { desc = "Escape terminal mode" })
map("n", "<Esc>", function ()
  vim.cmd("noh")
  vim.cmd("echo ''")
end, { desc = "Clear", silent = true })


local function copy_current_path(modifier)
  local value = vim.fn.expand("%" .. modifier)
  vim.fn.setreg("+", value)
  print("Copied: " .. value)
end

vim.keymap.set("n", "<leader>yf", function()
  copy_current_path(":t")
end, { desc = "Copy filename" })

vim.keymap.set("n", "<leader>yF", function()
  copy_current_path(":t:r")
end, { desc = "Copy filename without extension" })

vim.keymap.set("n", "<leader>yp", function()
  copy_current_path(":p")
end, { desc = "Copy full path" })

vim.keymap.set("n", "<leader>yr", function()
  copy_current_path(":.")
end, { desc = "Copy relative path" })
