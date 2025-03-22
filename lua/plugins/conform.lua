return {
  {
    "stevearc/conform.nvim",

    opts = function(
    )
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

      -- Now it's safe to set the keymap
      vim.keymap.set("n", "<leader>fm", function()
        conform.format { lsp_fallback = true }
      end, { desc = "general format file" })
    end,
  },
}
