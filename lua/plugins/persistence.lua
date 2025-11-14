return {
  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    opts = {},
    keys = {
      {
        "<leader>qj",
        function()
          require("persistence").select()
        end,
        desc = "Session Select Session",
      },
      {
        "<leader>ql",
        function()
          require("persistence").load { last = true }
        end,
        desc = "Session Restore Last Session",
      },
      {
        "<leader>qk",
        function()
          require("persistence").load()
        end,
        desc = "Session Restore Session",
      },
      {
        "<leader>qd",
        function()
          require("persistence").stop()
        end,
        desc = "Session Don't Save Current Session",
      },
      {
        "<leader>qq",
        function()
          vim.cmd "qa"
        end,
        desc = "General Quit",
      },
    },
  },
}
