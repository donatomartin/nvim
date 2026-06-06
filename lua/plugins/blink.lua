vim.pack.add({
  'https://github.com/saghen/blink.lib', 'https://github.com/saghen/blink.cmp'
})

local cmp = require('blink.cmp')
cmp.build():pwait()
cmp.setup({
  snippets = {
    preset = "luasnip"
  },
  sources = {
    default = {
      "lsp",
      "snippets",
      "path",
      "buffer"
    }
  }
})
