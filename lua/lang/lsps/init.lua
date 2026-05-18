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
      stepSkipped = "mason",
    },
    ["sonarlint"] = {
      stepSkipped = "config",
      package = "sonarlint-language-server",
    }
  }
end

local function processMapByType(type)
  local t = {}
  for _, value in pairs(M.getLspMap()) do

    local element = value.config
    if (type == "mason") then
      element = value.package
    end

    if not value.stepSkipped == type or not value.stepSkipped == "both" then
      t[#t + 1] = element
    end

    return t
  end
end

function M.getLsps()
  return processMapByType("config")
end

function M.getMasonLsps()
  return processMapByType("mason")
end

return M
