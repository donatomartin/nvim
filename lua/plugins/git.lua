return {
  {
    "lewis6991/gitsigns.nvim",
    event = "User FilePost",
    opts = function()
      dofile(vim.g.base46_cache .. "git")

      return {
        signs = {
          delete = { text = "󰍵" },
          changedelete = { text = "󱕖" },
        },
      }
    end,
    keys = {
      { "<leader>gs", function() require("gitsigns").preview_hunk() end, desc="gitsigns preview hunk" }
    },
  },
}
