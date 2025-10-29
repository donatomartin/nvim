return {
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
    config = function()
      local harpoon = require("harpoon")
      harpoon:setup({
        settings = { save_on_toggle = true },
      })

      -- Telescope integration
      pcall(function()
        require("telescope").load_extension("harpoon")
      end)

      -- Keymaps
      local list = function() return harpoon:list() end
      vim.keymap.set("n", "<leader>a", function() list():add() end, { desc = "Harpoon add file" })
      vim.keymap.set("n", "<leader>h", function()
        harpoon.ui:toggle_quick_menu(list())
      end, { desc = "Harpoon quick menu" })

      -- Navigation (open directories in Oil)
      local function open(item)
        local path = item.value
        if vim.fn.isdirectory(path) == 1 then
          vim.cmd("Oil " .. path)
        else
          vim.cmd("edit " .. path)
        end
      end

      for i = 1, 10 do
        vim.keymap.set("n", "<leader>" .. (i % 10), function()
          local item = list():get(i)
          if item then open(item) end
        end, { desc = "Harpoon entry " .. i })
      end

      -- Wrapped navigation unchanged
      vim.keymap.set("n", "<A-n>", function() list():next({ ui_nav_wrap = true }) end)
      vim.keymap.set("n", "<A-p>", function() list():prev({ ui_nav_wrap = true }) end)

      -- Wrapped navigation
      vim.keymap.set("n", "<A-n>", function() list():next({ ui_nav_wrap = true }) end,
        { desc = "Harpoon next" })
      vim.keymap.set("n", "<A-p>", function() list():prev({ ui_nav_wrap = true }) end,
        { desc = "Harpoon prev" })
    end,
  },
}
