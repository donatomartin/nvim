return {
  {
    "abecodes/tabout.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    lazy = false,
    config = function()
      require("tabout").setup {
        tabkey = "<Tab>", -- Key to tab out
        backwards_tabkey = "<S-Tab>", -- Key to tab back
        act_as_tab = true, -- If at the start of a word, act like a normal tab
        act_as_shift_tab = false, -- Disable shift-tab acting as shift-tab
        enable_backwards = true, -- Allow backwards tabbing
        completion = false, -- Disable conflict with completion plugins
        ignore_beginning = false,
        exclude = {}, -- Filetypes to exclude
      }
    end,
  },
}
