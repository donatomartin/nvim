
-- Define leader key
vim.g.mapleader = " "
vim.g.maplocalleader = ","

-- UI
vim.wo.number = true
vim.wo.relativenumber = true
vim.o.undofile = true
vim.o.termguicolors = true
vim.o.cursorline = true

-- Editing
vim.o.expandtab = true
vim.o.shiftwidth = 2
vim.o.tabstop = 2
vim.o.smartindent = true
vim.o.wrap = false

-- Search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Misc
vim.o.mouse = "a"
vim.o.splitright = true
vim.o.splitbelow = true

-- Set system clipboard
vim.opt.clipboard = { "unnamed", "unnamedplus" }

-- Create missing directories before saving
vim.api.nvim_create_autocmd("BufWritePre", {
  group = vim.api.nvim_create_augroup("MKDIR_ON_SAVE", { clear = true }),
  callback = function(args)
    local path = vim.fn.fnamemodify(args.match, ":p:h")
    if path ~= nil and path ~= "" and not vim.loop.fs_stat(path) then
      vim.fn.mkdir(path, "p")
    end
  end,
})

-- Remember last cursor position
-- From reddit user evergreengt
-- Replying on post https://www.reddit.com/r/neovim/comments/1052d98/how_to_save_last_position_in_files/
local lastplace = vim.api.nvim_create_augroup("LastPlace", {})
vim.api.nvim_clear_autocmds({ group = lastplace })
vim.api.nvim_create_autocmd("BufReadPost", {
    group = lastplace,
    pattern = { "*" },
    desc = "remember last cursor place",
    callback = function()
        local mark = vim.api.nvim_buf_get_mark(0, '"')
        local lcount = vim.api.nvim_buf_line_count(0)
        if mark[1] > 0 and mark[1] <= lcount then
            pcall(vim.api.nvim_win_set_cursor, 0, mark)
        end
    end,
})

-- Create user command for reloading config
vim.api.nvim_create_user_command("ReloadConfig", function()
  for name,_ in pairs(package.loaded) do
    if name:match('^user') or name:match('^plugins') then package.loaded[name] = nil end
  end
  dofile(vim.env.MYVIMRC)
  print("Config reloaded!")
end, {})

-- Qol keymaps
vim.keymap.set({"n","v"}, "<C-c>", ":%y+<CR>", { desc = "Yank file to system clipboard" })
vim.keymap.set("n", "<Esc>", ":noh<CR>", { desc = "Clear search hl" })
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-N>", { desc = "Escape terminal mode" })
vim.keymap.set("n", ";", ":!")

-- Set catppuccin mocha theme
vim.cmd("colorscheme catppuccin_mocha")
