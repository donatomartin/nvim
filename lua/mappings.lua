-- lua/mappings.lua

require "nvchad.mappings"

local map = vim.keymap.set

map("i", "jk", "<ESC>")
map("t", "jk", [[<C-\><C-n>]])

-- Map a key to execute commands :!
map(
  "n",
  ";",
  ':lua vim.api.nvim_feedkeys(":! ", "m", true)<CR>',
  { noremap = true, silent = true, desc = "Terminal execute command" }
)

-- Map a key to accept Copilot suggestions
map("i", "<C-l>", function()
  vim.fn.feedkeys(vim.fn["copilot#Accept"](), "")
end, { desc = "Copilot Accept", noremap = true, silent = true })

-- Map a key to open telescope project
map("n", "<leader>fp", ":Telescope project<CR>", { noremap = true, silent = true, desc = "Telescope Project" })

-- True Vim Experience
vim.opt.mouse = ""
map({"n", "i", "v", "t"}, "<left>", '<cmd>echo "Use h to move!!"<CR>')
map({"n", "i", "v", "t"}, "<right>", '<cmd>echo "Use l to move!!"<CR>')
map({"n", "i", "v", "t"}, "<up>", '<cmd>echo "Use k to move!!"<CR>')
map({"n", "i", "v", "t"}, "<down>", '<cmd>echo "Use j to move!!"<CR>')
