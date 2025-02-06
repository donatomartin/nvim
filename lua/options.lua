require "nvchad.options"

-- terminal options
vim.opt.shell = 'pwsh'
vim.opt.shellcmdflag = '-nologo -noprofile -ExecutionPolicy RemoteSigned -command'
vim.opt.shellxquote = ''

vim.api.nvim_create_autocmd("TermOpen", {
  pattern = "*",
  callback = function ()
    vim.wo.number = false
    vim.wo.relativenumber = false
  end
})

-- other options
vim.o.relativenumber = true
vim.o.number = true
vim.o.mouse=""
vim.o.clipboard=""

