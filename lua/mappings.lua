-- lua/mappings.lua

-- NVChad Mappings
local map = vim.keymap.set

-- Disable F1
map({"n", "v", "i", "t"}, "<F1>", "<cmd>echo 'F1 is disabled'<CR>", { desc = "F1 is disabled" })

-- Insert Mode Move
map("i", "<C-b>", "<ESC>^i", { desc = "move beginning of line" })
map("i", "<C-e>", "<End>", { desc = "move end of line" })

map("i", "<C-h>", "<Left>", { desc = "move left" })
map("i", "<C-l>", "<Right>", { desc = "move right" })
map("i", "<C-j>", "<Down>", { desc = "move down" })
map("i", "<C-k>", "<Up>", { desc = "move up" })

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

-- Exit Terminal Mode
map("t", "<Esc><Esc>", "<C-\\><C-N>", { desc = "Terminal escape terminal mode" })

-- Toggle Terminal
map({ "n", "t" }, "<A-v>", function()
  require("nvchad.term").toggle { pos = "vsp", id = "vtoggleTerm" }
end, { desc = "Terminal toggle vertical" })

map({ "n", "t" }, "<A-g>", function()
  require("nvchad.term").toggle { pos = "sp", id = "htoggleTerm" }
end, { desc = "Terminal toggle horizontal" })

map({ "n", "t" }, "<A-i>", function()
  require("nvchad.term").toggle { pos = "float", id = "floatTerm" }
end, { desc = "Terminal toggle floating" })

-- Map a key to execute commands :!
map(
  "n",
  ";",
  ':lua vim.api.nvim_feedkeys(":! ", "m", true)<CR>',
  { noremap = true, silent = true, desc = "Terminal execute command" }
)
