local map = vim.keymap.set

map("n", "<C-h>", "<cmd> TmuxNavigateLeft<cr>", { noremap = true, silent = true, desc = "Tmux Move Left" })
map("n", "<C-j>", "<cmd> TmuxNavigateDown<cr>", { noremap = true, silent = true, desc = "Tmux Move Down" })
map("n", "<C-k>", "<cmd> TmuxNavigateUp<cr>", { noremap = true, silent = true, desc = "Tmux Move Up" })
map("n", "<C-l>", "<cmd> TmuxNavigateRight<cr>", { noremap = true, silent = true, desc = "Tmux Move Right" })

return {
  {
    "christoomey/vim-tmux-navigator",
    lazy = false,
  },
  {
    "RyanMillerC/better-vim-tmux-resizer",
    lazy = false,
  }
}
