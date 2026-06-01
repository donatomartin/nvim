local map = vim.keymap.set

map({"n","v"}, "<leader>y", ":%y+<cr>", { desc = "Yank file to system clipboard" })
map({"n","v"}, "<C-c>", ":%y+<cr>", { desc = "Yank file to system clipboard" })
map("n", ";", ":lua ")
map({"n", "v", "i", "t"}, "<F1>", "", { desc = "F1 is disabled" })
map("t", "<Esc><Esc>", "<C-\\><C-N>", { desc = "Escape terminal mode" })
map("n", "<Esc>", function ()
  vim.cmd("noh")
  vim.cmd("echo ''")
end, { desc = "Clear", silent = true })

-- Normal, Visual, and Insert mode mappings for Shift + Scroll Up (Scroll Left)
vim.keymap.set({'n', 'v', 'i'}, '<S-ScrollWheelUp>', '<ScrollWheelLeft>')
vim.keymap.set({'n', 'v', 'i'}, '<S-2-ScrollWheelUp>', '<2-ScrollWheelLeft>')
vim.keymap.set({'n', 'v', 'i'}, '<S-3-ScrollWheelUp>', '<3-ScrollWheelLeft>')
vim.keymap.set({'n', 'v', 'i'}, '<S-4-ScrollWheelUp>', '<4-ScrollWheelLeft>')

-- Normal, Visual, and Insert mode mappings for Shift + Scroll Down (Scroll Right)
vim.keymap.set({'n', 'v', 'i'}, '<S-ScrollWheelDown>', '<ScrollWheelRight>')
vim.keymap.set({'n', 'v', 'i'}, '<S-2-ScrollWheelDown>', '<2-ScrollWheelRight>')
vim.keymap.set({'n', 'v', 'i'}, '<S-3-ScrollWheelDown>', '<3-ScrollWheelRight>')
vim.keymap.set({'n', 'v', 'i'}, '<S-4-ScrollWheelDown>', '<4-ScrollWheelRight>')
