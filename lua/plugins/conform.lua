return {
	{
		"stevearc/conform.nvim",
		opts = function()
			return {
				formatters_by_ft = {
          require("lang.formatters").getFormatterMap()
				},
				format_on_save = false,
			}
		end,
		config = function(_, opts)
			local conform = require("conform")
			conform.setup(opts)
		end,
		keys = {
			{
				"<leader>fm",
				function()
					require("conform").format({ lsp_fallback = true })
				end,
				desc = "general format file",
			},
		},
	},
}
