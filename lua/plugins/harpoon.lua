return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  lazy = false,
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local harpoon = require "harpoon"
    harpoon:setup()
  end,
  keys = {
    {
      "<leader>hm",
      function()
        require("harpoon").list():add()
      end,
      desc = "Harpoon: Mark file",
    },
    {
      "<leader>ha",
      function()
        require("harpoon").ui:toggle_quick_menu(require("harpoon").list())
      end,
      desc = "Harpoon: Toggle quick menu",
    },
    {
      "<leader>hn",
      function()
        require("harpoon").list():next()
      end,
      desc = "Harpoon: Next file",
    },
    {
      "<leader>hp",
      function()
        require("harpoon").list():prev()
      end,
      desc = "Harpoon: Previous file",
    },
    {
      "<leader>1",
      function()
        require("harpoon").list():select(1)
      end,
      desc = "Harpoon: Go to file 1",
    },
    {
      "<leader>2",
      function()
        require("harpoon").list():select(2)
      end,
      desc = "Harpoon: Go to file 2",
    },
    {
      "<leader>3",
      function()
        require("harpoon").list():select(3)
      end,
      desc = "Harpoon: Go to file 3",
    },
    {
      "<leader>4",
      function()
        require("harpoon").list():select(4)
      end,
      desc = "Harpoon: Go to file 4",
    },
    {
      "<leader>5",
      function()
        require("harpoon").list():select(5)
      end,
      desc = "Harpoon: Go to file 5",
    },
  },
}
