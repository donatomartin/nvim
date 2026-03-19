if not vim.g.vscode then
return {
  {
    "williamboman/mason.nvim",
    opts = function()
      return {
        PATH = "prepend", -- ← change this
        registries = {
          "github:nvim-java/mason-registry",
          "github:mason-org/mason-registry",
        },
      }
    end,
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    config = function()
      require("mason-tool-installer").setup({
        ensure_installed = {
          -- formatters
          "stylua",
          "prettier",
          "autopep8",
          "nixfmt",
          "google-java-format",

          -- lsps
          "jdtls",
          "lua-language-server",
          "pyright",
          "html-lsp",
          "typescript-language-server",
          "gopls",
          "css-lsp",

          -- dependencies
          "lombok-nightly",
        }
      })
    end,
  },
}
else return {} end
