return {
	{
		"williamboman/mason.nvim",
		opts = function()
			return {
				registries = {
					"github:nvim-java/mason-registry",
					"github:mason-org/mason-registry",
				},
			}
		end,
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = {
      "williamboman/mason.nvim"
    },
		config = function()
      local ensure_installed = {
        "lombok-nightly",
      }

      vim.list_extend(ensure_installed, require("lang.formatters").getMasonFormatters())
      vim.list_extend(ensure_installed, require("lang.lsps").getMasonLsps())

			require("mason-tool-installer").setup({
				ensure_installed = ensure_installed
			})

		end,
	},
}
