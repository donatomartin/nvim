-- conform

return {
  {
    "stevearc/conform.nvim",

    opts = function()
      return {
        formatters_by_ft = {
          lua = { "stylua" },
          java = { "google-java-format" },
          css = { "prettier" },
          html = { "prettier" },
          python = { "autopep8" },
        },

        format_on_save = {
          timeout_ms = 500,
          lsp_fallback = true,
        },
      }
    end,

    config = function(_, opts)
      local conform = require "conform"
      conform.setup(opts)
    end,

    keys = {
      {
        "<leader>fm",
        function()
          require("conform").format { lsp_fallback = true }
        end,
        desc = "general format file",
      },
    },
  },
}
