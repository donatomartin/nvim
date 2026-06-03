local M = {}

function M.config(on_attach)
  vim.lsp.config("*", {
    root_markers = { ".git" },
    on_attach = on_attach,
  })

  require("lang.lspconfigs.lua")
  require("lang.lspconfigs.latex")
  require("lang.lspconfigs.bash")

  vim.lsp.enable(M.getLsps())
end

function M.getLspMap()
  return {
    ["lua_ls"] = {
      package = "lua-language-server",
      config = "lua_ls",
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
      dependencies = { "java" },
    },
    ["sonarlint"] = {
      package = "sonarlint-language-server",
    },
    ["bash"] = {
      package = { "bash-language-server" },
      config = { "bashls" },
    },
    ["ltex_plus"] = {
      package = "ltex-ls-plus",
      config = "ltex_plus",
    },
    ["nixd"] = {
      config = "nixd",
    },
  }
end

local function processMapByType(property)
  local t = {}
  for _, value in pairs(M.getLspMap()) do
    local element = value[property]

    -- in case the element is an array
    if type(element) == "table" then
      for _, innerValue in pairs(element) do
        t[#t + 1] = innerValue
      end
    else
      t[#t + 1] = element
    end
  end
  return t
end

function M.getLsps()
  return processMapByType("config")
end

function M.getMasonLsps()
  return processMapByType("package")
end

local map = function(mode, lhs, rhs, bufnr)
  if bufnr then
    vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, silent = true })
  else
    vim.keymap.set(mode, lhs, rhs, { silent = true })
  end
end

function M.on_attach(_, bufnr)
  map("n", "gt", vim.lsp.buf.type_definition, bufnr)
  map("n", "gd", vim.lsp.buf.definition, bufnr)
  map("n", "gD", vim.lsp.buf.declaration, bufnr)
  map("n", "gi", vim.lsp.buf.implementation, bufnr)
  map("n", "gr", vim.lsp.buf.references, bufnr)
  map("n", "gci", vim.lsp.buf.incoming_calls, bufnr)
  map("n", "gco", vim.lsp.buf.outgoing_calls, bufnr)

  map("n", "K", vim.lsp.buf.hover, bufnr)
  map("n", "<leader>rn", vim.lsp.buf.rename, bufnr)
  map("n", "<leader>ca", vim.lsp.buf.code_action, bufnr)
  map("n", "<leader>cd", vim.diagnostic.open_float, bufnr)
  map("n", "<leader>cw", vim.lsp.buf.workspace_diagnostics, bufnr)
  map("n", "<leader>cl", vim.diagnostic.setloclist, bufnr)
  map("n", "<leader>lf", vim.lsp.buf.format, bufnr)
  map("n", "<leader>cn", function ()
    vim.diagnostic.jump({count = 1})
  end , bufnr)
  map("n", "<leader>cp", function ()
    vim.diagnostic.jump({count = -1})
  end , bufnr)

end

function M.start()
  M.config(M.on_attach)
end

return M
