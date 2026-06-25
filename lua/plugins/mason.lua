vim.pack.add({
  "https://github.com/williamboman/mason.nvim",
  "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim",
})

require "mason".setup({
  registries = {
    "github:nvim-java/mason-registry",
    "github:mason-org/mason-registry",
  }
})

require "mason-tool-installer".setup({
  ensure_installed = require("lang").getMasonPackages()
})
