local map = vim.keymap.set

map({"n","v"}, "<leader>y", ":%y+<cr>", { desc = "Yank file to system clipboard" })
map({"n","v"}, "<C-c>", ":%y+<cr>", { desc = "Yank file to system clipboard" })
map("n", "<Esc>", ":noh<cr>", { desc = "Clear search hl" })
map("t", "<Esc><Esc>", "<C-\\><C-N>", { desc = "Escape terminal mode" })
map("n", ";", ":!")
map({"n", "v", "i", "t"}, "<F1>", "", { desc = "F1 is disabled" })
