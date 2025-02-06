-- lua/configs/lspconfig.lua

-- load defaults i.e lua_lsp

require("java").setup()

require("nvchad.configs.lspconfig").defaults()

local lspconfig = require "lspconfig"

lspconfig.jdtls.setup({})

-- EXAMPLE
local servers = {
  "html",
  "cssls",
  "clangd",
  "pyright",
  "gopls",
}
local nvlsp = require "nvchad.configs.lspconfig"

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  }
end
