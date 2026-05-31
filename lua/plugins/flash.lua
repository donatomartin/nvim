vim.pack.add({
  "https://github.com/folke/flash.nvim"
})

local utils = require "utils"

utils.enableMappings({
  {
    "s",
    function()
      require("flash").jump()
    end,
    desc = "Flash",
    mode = { "n", "x", "o" },
  },
})
