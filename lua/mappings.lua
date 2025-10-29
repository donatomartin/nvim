local map = vim.keymap.set

map({"n","v"}, "<C-c>", ":%y+<CR>", { desc = "Yank file to system clipboard" })
map("n", "<Esc>", ":noh<CR>", { desc = "Clear search hl" })
map("t", "<Esc><Esc>", "<C-\\><C-N>", { desc = "Escape terminal mode" })
map("n", ";", ":!")
map({"n", "v", "i", "t"}, "<F1>", "", { desc = "F1 is disabled" })
