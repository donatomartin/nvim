local M = {}

-- Loaded by lspsaga, after neovim/nvim-lspconfig
-- has loaded default configurations
function M.config(on_attach)
  vim.lsp.config("*", {
    root_markers = { ".git" },
    on_attach = on_attach,
  })

  require("lang.lsps.java")
  require("lang.lsps.lua")
  require("lang.lsps.typescript")
  require("lang.lsps.latex")

  vim.lsp.enable(M.getLsps())
end

function M.getLspMap()
  return {
    ["lua_ls"] = "lua-language-server",
    ["pyright"] = "pyright",
    ["vtsls"] = "vtsls",
    ["html"] = "html-lsp",
    ["cssls"] = "css-lsp",
    ["gopls"] = "gopls",
    ["jdtls"] = "jdtls",
    ["ltex_plus"] = "ltex-ls-plus",
    ["nixd"] = "skip", -- better installed form nixpkgs
  }
end

function M.getLsps()
  local t = {}
  for key, _ in pairs(M.getLspMap()) do
    t[#t + 1] = key
  end
  return t
end

function M.getMasonLsps()
  local t = {}
  for _, value in pairs(M.getLspMap()) do
    if value ~= "skip" then
      t[#t + 1] = value
    end
  end
  return t
end

return M
