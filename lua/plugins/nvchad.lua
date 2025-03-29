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
    keys = {
      { "<leader>th", function() require("nvchad.themes").open() end, desc = "NVChad themes" },
      { "<tab>", function() require("nvchad.tabufline").next() end, desc = "buffer goto next" },
      { "<S-tab>", function() require("nvchad.tabufline").prev() end, desc = "buffer goto prev" },
      { "<leader>x", function() require("nvchad.tabufline").close_buffer() end, desc = "buffer close" },
    },
  },

  { "nvzone/volt" },
  { "nvzone/menu" },
  { "nvzone/minty", cmd = { "Huefy", "Shades" } },
}
