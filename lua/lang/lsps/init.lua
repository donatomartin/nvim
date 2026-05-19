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
  require("lang.lsps.latex")

  vim.lsp.enable(M.getLsps())
end

function M.getLspMap()
  return {
    ["lua_ls"] = {
      package = "lua-language-server",
      config = "lua_ls";
    },
    ["pyright"] = {
      package = "pyright",
      config = "pyright",
      dependencies = { "node", "python" },
    },
    ["vtsls"] = {
      package = "vtsls",
      config = "vtsls",
      dependencies = { "node" },
    },
    ["html"] = {
      package = "html-lsp",
      config = "html",
      dependencies = { "node" },
    },
    ["cssls"] = {
      package = "css-lsp",
      config = "cssls",
      dependencies = { "node" },
    },
    ["gopls"] = {
      package = "gopls",
      config = "gopls",
      dependencies = { "node" },
    },
    ["jdtls"] = {
      package = "jdtls",
      config = "jdtls",
      dependencies = { "java" },
    },
    ["ltex_plus"] = {
      package = "ltex-ls-plus",
      config = "ltex_plus",
    },
    ["nixd"] = {
      config = "nixd",
    },
    ["sonarlint"] = {
      package = "sonarlint-language-server",
    }
  }
end

local function processMapByType(property)
  local t = {}
  for _, value in pairs(M.getLspMap()) do

    local element = value[property]

    t[#t + 1] = element

  end
  return t
end

function M.getLsps()
  return processMapByType("config")
end

function M.getMasonLsps()
  return processMapByType("package")
end

return M
