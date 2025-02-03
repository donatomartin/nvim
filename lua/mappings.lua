-- mappings.lua

require "nvchad.mappings"
-- add yours here

local map = vim.keymap.set

map("i", "jk", "<ESC>")
map("t", "jk", [[<C-\><C-n>]])

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

-- Define a function to toggle the terminal
function ToggleTerminal()
  -- Check if the terminal buffer exists
  local term_buf = vim.fn.bufnr('term://')
  if term_buf == -1 then
    -- If the terminal buffer doesn't exist, open a new one
    vim.cmd('split | term')
  else
    -- If the terminal buffer exists, toggle its visibility
    local term_win = vim.fn.bufwinnr(term_buf)
    if term_win == -1 then
      -- If the terminal window is not visible, open it
      vim.cmd('split | buffer ' .. term_buf)
    else
      -- If the terminal window is visible, close it
      vim.cmd(term_win .. 'wincmd c')
    end
  end
end

-- Map a key to toggle the terminal (e.g., <leader>t)
map('n', '<leader>j', ':lua ToggleTerminal()<CR>', { noremap = true, silent = true })
map('n', ';', ':lua vim.api.nvim_feedkeys(":! ", "m", true)<CR>', { noremap = true, silent = true })
