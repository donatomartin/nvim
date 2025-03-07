-- lua/mappings.lua

-- NVChad Mappings
local map = vim.keymap.set

-- Cheatsheet
map("n", "<leader>ch", "<cmd>NvCheatsheet<CR>", { desc = "toggle nvcheatsheet" })

-- Insert Mode Move
map("i", "<C-b>", "<ESC>^i", { desc = "move beginning of line" })
map("i", "<C-e>", "<End>", { desc = "move end of line" })

map("i", "<C-h>", "<Left>", { desc = "move left" })
map("i", "<C-l>", "<Right>", { desc = "move right" })
map("i", "<C-j>", "<Down>", { desc = "move down" })
map("i", "<C-k>", "<Up>", { desc = "move up" })

-- Switch Windows
map("n", "<C-h>", "wincmd h", { desc = "Window switch left" })
map("n", "<C-l>", "wincmd l", { desc = "Window switch right" })
map("n", "<C-j>", "wincmd j", { desc = "Window switch down" })
map("n", "<C-k>", "wincmd k", { desc = "Window switch up" })

-- Switch Windows (from terminal)
map("t", "<C-h>", "<C-\\><C-n><C-w>h", { desc = "Window switch left" })
map("t", "<C-l>", "<C-\\><C-n><C-w>l", { desc = "Window switch right" })
map("t", "<C-j>", "<C-\\><C-n><C-w>j", { desc = "Window switch down" })
map("t", "<C-k>", "<C-\\><C-n><C-w>k", { desc = "Window switch up" })

-- Resize Windows
map("n", "<left>", ":vertical resize +5<CR>", { desc = "Window resize left" })
map("n", "<right>", ":vertical resize -5<CR>", { desc = "Window resize right" })
map("n", "<down>", ":horizontal resize -5<CR>", { desc = "Window resize down" })
map("n", "<up>", ":horizontal resize +5<CR>", { desc = "Window resize up" })

-- Search Highlighting
map("n", "<Esc>", "<cmd>noh<CR>", { desc = "general clear highlights" })

-- Save
map({ "n", "i" }, "<C-s>", "<cmd>w<CR>", { desc = "general save file" })
map({ "n" }, "<leader>ss", ":SudaWrite<CR>", { desc = "general sudo save file" })

-- Copy
map("n", "<C-c>", "<cmd>%y+<CR>", { desc = "general copy whole file" })

-- Number
map("n", "<leader>n", "<cmd>set nu!<CR>", { desc = "toggle line number" })
map("n", "<leader>rn", "<cmd>set rnu!<CR>", { desc = "toggle relative number" })

-- Conform Format
map("n", "<leader>fm", function()
  require("conform").format { lsp_fallback = true }
end, { desc = "general format file" })

-- global lsp mappings
map("n", "<leader>ds", vim.diagnostic.setloclist, { desc = "LSP diagnostic loclist" })

-- tabufline
map("n", "<tab>", function()
  require("nvchad.tabufline").next()
end, { desc = "buffer goto next" })

map("n", "<S-tab>", function()
  require("nvchad.tabufline").prev()
end, { desc = "buffer goto prev" })

map("n", "<leader>x", function()
  require("nvchad.tabufline").close_buffer()
end, { desc = "buffer close" })
-- nvimtree
map("n", "<C-n>", "<cmd>NvimTreeToggle<CR>", { desc = "nvimtree toggle window" })
map("n", "<leader>e", "<cmd>NvimTreeFocus<CR>", { desc = "nvimtree focus window" })

-- telescope
map("n", "<leader>fw", "<cmd>Telescope live_grep<CR>", { desc = "telescope live grep" })
map("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { desc = "telescope find buffers" })
map("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", { desc = "telescope help page" })
map("n", "<leader>ma", "<cmd>Telescope marks<CR>", { desc = "telescope find marks" })
map("n", "<leader>fo", "<cmd>Telescope oldfiles<CR>", { desc = "telescope find oldfiles" })
map("n", "<leader>fz", "<cmd>Telescope current_buffer_fuzzy_find<CR>", { desc = "telescope find in current buffer" })
map("n", "<leader>cm", "<cmd>Telescope git_commits<CR>", { desc = "telescope git commits" })
map("n", "<leader>gt", "<cmd>Telescope git_status<CR>", { desc = "telescope git status" })
map("n", "<leader>pt", "<cmd>Telescope terms<CR>", { desc = "telescope pick hidden term" })
map(
  "n",
  "<leader>cn",
  "<cmd>edit $MYVIMRC <CR> <cmd>cd " .. vim.fn.stdpath "config" .. " <CR>",
  { desc = "telescope open config" }
)
map("n", "<leader>fp", ":Telescope project<CR>", { noremap = true, silent = true, desc = "Telescope Project" })
map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "telescope find files" })
map(
  "n",
  "<leader>fa",
  "<cmd>Telescope find_files follow=true no_ignore=true hidden=true<CR>",
  { desc = "telescope find all files" }
)

-- Themes
map("n", "<leader>th", function()
  require("nvchad.themes").open()
end, { desc = "NVChad themes" })

-- Exit Terminal Mode
map("t", "<Esc>", "<C-\\><C-N>", { desc = "Terminal escape terminal mode" })

-- Toggle Terminal
map({ "n", "t" }, "<A-v>", function()
  require("nvchad.term").toggle { pos = "vsp", id = "vtoggleTerm" }
end, { desc = "Terminal toggle vertical" })

map({ "n", "t" }, "<A-h>", function()
  require("nvchad.term").toggle { pos = "sp", id = "htoggleTerm" }
end, { desc = "Terminal toggle horizontal" })

map({ "n", "t" }, "<A-i>", function()
  require("nvchad.term").toggle { pos = "float", id = "floatTerm" }
end, { desc = "Terminal toggle floating" })

-- whichkey
map("n", "<leader>wK", "<cmd>WhichKey <CR>", { desc = "whichkey all keymaps" })

map("n", "<leader>wk", function()
  vim.cmd("WhichKey " .. vim.fn.input "WhichKey: ")
end, { desc = "whichkey query lookup" })

-- Map a key to execute commands :!
map(
  "n",
  ";",
  ':lua vim.api.nvim_feedkeys(":! ", "m", true)<CR>',
  { noremap = true, silent = true, desc = "Terminal execute command" }
)

-- Exit Vim
map("n", "<leader>qq", function()
  require("nvim-tree.api").tree.close()
  require("dapui").close()
  vim.cmd "q"
end, { noremap = true, silent = true, desc = "General Quit" })

map(
  "n",
  "<leader>qw",
  [[<cmd>lua require("persistence").save()<cr>:qa<cr>]],
  { desc = "Session Save and Exit", noremap = true, silent = true }
)

-- Tmux Navigation
map("n", "<C-h>", "<cmd> TmuxNavigateLeft<CR>", { noremap = true, silent = true, desc = "Tmux Move Left" })
map("n", "<C-j>", "<cmd> TmuxNavigateDown<CR>", { noremap = true, silent = true, desc = "Tmux Move Down" })
map("n", "<C-k>", "<cmd> TmuxNavigateUp<CR>", { noremap = true, silent = true, desc = "Tmux Move Up" })
map("n", "<C-l>", "<cmd> TmuxNavigateRight<CR>", { noremap = true, silent = true, desc = "Tmux Move Right" })
