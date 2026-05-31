local M = {}

function M.enableMappings(mapList)
  for _, map in ipairs(mapList) do
    vim.keymap.set(
      map.mode or "n",
      map[1],
      map[2],
      {
        silent = true,
        desc = map.desc,
      }
    )
  end
end

return M
