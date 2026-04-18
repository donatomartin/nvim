local M = {}

function M.getFormatterMap()
  return {
    lua = { "stylua" },
    java = { "google-java-format" },
    css = { "prettier" },
    html = { "prettier" },
  }
end

function M.getMasonFormatters()
  local t = {}
  for _, value in pairs(M.getFormatterMap()) do
      t[#t+1] = value[1]
  end
  return t
end

return M
