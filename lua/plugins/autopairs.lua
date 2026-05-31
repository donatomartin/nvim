vim.pack.add({
  "https://github.com/windwp/nvim-autopairs"
})

local opts = {
  fast_wrap = {},
  disable_filetype = { "TelescopePrompt", "vim" },
}

require("nvim-autopairs").setup(opts)
