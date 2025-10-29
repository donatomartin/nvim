-- Tmux Navigation

local map = vim.keymap.set

map("n", "<C-h>", "<cmd> TmuxNavigateLeft<CR>", { noremap = true, silent = true, desc = "Tmux Move Left" })
map("n", "<C-j>", "<cmd> TmuxNavigateDown<CR>", { noremap = true, silent = true, desc = "Tmux Move Down" })
map("n", "<C-k>", "<cmd> TmuxNavigateUp<CR>", { noremap = true, silent = true, desc = "Tmux Move Up" })
map("n", "<C-l>", "<cmd> TmuxNavigateRight<CR>", { noremap = true, silent = true, desc = "Tmux Move Right" })

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
