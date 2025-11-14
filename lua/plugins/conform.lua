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
          nix = { "nixfmt" },
        },

        format_on_save = false,
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

  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = { "williamboman/mason.nvim", "williamboman/mason-lspconfig.nvim" },
    config = function()
      require("mason-tool-installer").setup {
        ensure_installed = {
          "stylua",
          "prettier",
          "autopep8",
          "nixfmt",
          "google-java-format",
        },
      }
    end,
  }
}
