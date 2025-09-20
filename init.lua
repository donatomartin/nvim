
vim.g.mapleader = " "
vim.g.maplocalleader = ","

local o, wo, bo = vim.o, vim.wo, vim.bo

-- UI
wo.number = true
wo.relativenumber = true
o.undofile = true
o.termguicolors = true
wo.signcolumn = "yes"
o.cursorline = true

-- Editing
o.expandtab = true
o.shiftwidth = 2
o.tabstop = 2
o.smartindent = true
o.wrap = false

-- Search
o.ignorecase = true
o.smartcase = true

-- Misc
o.mouse = "a"
o.splitright = true
o.splitbelow = true

-- OSC52: Requires nvim > 0.10
vim.g.clipboard = {
  name = "osc52",
  copy = {
    ["+"] = require("vim.ui.clipboard.osc52").copy("+"),
    ["*"] = require("vim.ui.clipboard.osc52").copy("*"),
  },
  paste = {
    ["+"] = require("vim.ui.clipboard.osc52").paste("+"),
    ["*"] = require("vim.ui.clipboard.osc52").paste("*"),
  },
}

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


local map = vim.keymap.set

map({"n","v"}, "<C-c>", ":%y+<CR>", { desc = "Yank file to system clipboard" })
map("n", "<Esc>", ":noh<CR>", { desc = "Clear search hl" })

vim.api.nvim_create_user_command("ReloadConfig", function()
  for name,_ in pairs(package.loaded) do
    if name:match('^user') or name:match('^plugins') then package.loaded[name] = nil end
  end
  dofile(vim.env.MYVIMRC)
  print("Config reloaded!")
end, {})

