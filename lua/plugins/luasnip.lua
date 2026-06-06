vim.pack.add({
  "https://github.com/rafamadriz/friendly-snippets",
  "https://github.com/L3MON4D3/LuaSnip"
})

require("luasnip.loaders.from_snipmate").load({ paths = { "./snippets" } })
require("luasnip.loaders.from_lua").load({ paths = { "./snippets/lua" } })

