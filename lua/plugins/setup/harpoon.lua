local harpoon = require("harpoon")
local utils = require("utils")
harpoon:setup({
  settings = { save_on_toggle = true },
})


-- Navigation (open directories in Oil)
local function open(item)
  local path = item.value
  if vim.fn.isdirectory(path) == 1 then
    vim.cmd("Oil " .. path)
  else
    vim.cmd("edit " .. path)
  end
end

local harpoon_entry_mappings = {}
for i = 1, 10 do
  harpoon_entry_mappings[#harpoon_entry_mappings + 1] = {
    "<leader>" .. (i % 10),
    function()
      local item = harpoon:list():get(i)
      if item then
        open(item)
      end
    end,
    desc = "Harpoon entry " .. i
  }
end
utils.enableMappings(harpoon_entry_mappings)

-- Wrapped navigation
utils.enableMappings({
  { "<leader>a", function() harpoon:list():add() end,                         desc = "Harpoon add file" },
  { "<leader>h", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, desc = "Harpoon quick menu" },
  { "<A-n>",     function() harpoon:list():next({ ui_nav_wrap = true }) end,  desc = "Harpoon next" },
  { "<A-p>",     function() harpoon:list():prev({ ui_nav_wrap = true }) end,  desc = "Harpoon previous" },
})
