vim.keymap.set({"n","v"}, "<C-c>", ":%y+<CR>", { desc = "Yank file to system clipboard" })
vim.keymap.set("n", "<Esc>", ":noh<CR>", { desc = "Clear search hl" })
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-N>", { desc = "Escape terminal mode" })
vim.keymap.set("n", ";", ":!")
