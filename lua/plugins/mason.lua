vim.pack.add({
  "https://github.com/williamboman/mason.nvim",
  "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim",
})

local ensure_installed = {
  "lombok-nightly",
}
vim.list_extend(ensure_installed, require("lang").getMasonLsps())

require "mason".setup()
require "mason-tool-installer".setup({
  ensure_installed = ensure_installed
})
