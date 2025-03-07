-- lua/plugins/init.lua

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
