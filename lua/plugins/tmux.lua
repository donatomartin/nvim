vim.pack.add({
  "https://github.com/christoomey/vim-tmux-navigator",
  "https://github.com/RyanMillerC/better-vim-tmux-resizer",
})

local map = vim.keymap.set

map("n", "<C-h>", "<cmd> TmuxNavigateLeft<cr>", { noremap = true, silent = true, desc = "Tmux Move Left" })
map("n", "<C-j>", "<cmd> TmuxNavigateDown<cr>", { noremap = true, silent = true, desc = "Tmux Move Down" })
map("n", "<C-k>", "<cmd> TmuxNavigateUp<cr>", { noremap = true, silent = true, desc = "Tmux Move Up" })
map("n", "<C-l>", "<cmd> TmuxNavigateRight<cr>", { noremap = true, silent = true, desc = "Tmux Move Right" })
