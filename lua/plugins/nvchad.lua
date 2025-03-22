-- lua/plugins/init.lua

local map = vim.keymap.set

-- Themes
map("n", "<leader>th", function()
  require("nvchad.themes").open()
end, { desc = "NVChad themes" })

-- tabufline
map("n", "<tab>", function()
  require("nvchad.tabufline").next()
end, { desc = "buffer goto next" })

map("n", "<S-tab>", function()
  require("nvchad.tabufline").prev()
end, { desc = "buffer goto prev" })

map("n", "<leader>x", function()
  require("nvchad.tabufline").close_buffer()
end, { desc = "buffer close" })

return {

  {
    "nvim-lua/plenary.nvim",
  },

  {
    "nvchad/base46",
    build = function()
      require("base46").load_all_highlights()
    end,
  },

  {
    "nvchad/ui",
    lazy = false,
    config = function()
      require "nvchad"
    end,
  },

  { "nvzone/volt" },
  { "nvzone/menu" },
  { "nvzone/minty", cmd = { "Huefy", "Shades" } },
}
