return {
	{
		"nvim-telescope/telescope.nvim",
		cmd = "Telescope",
		opts = function()
			return {
				defaults = {
					prompt_prefix = "   ",
					selection_caret = " ",
					entry_prefix = " ",
					sorting_strategy = "ascending",
					path_display = { "truncate" },
					layout_config = {
						horizontal = {
							prompt_position = "bottom",
							preview_width = 0.55,
						},
						width = 0.87,
						height = 0.80,
					},
					mappings = {
						n = { ["q"] = require("telescope.actions").close },
					},
				},
			}
		end,

		keys = {
			{
				"<leader>ff",
				function()
					require("telescope.builtin").find_files({
						find_command = {
							"fd",
							"--type=f",
							"--hidden",
							"--no-ignore",
							"--exclude",
							".git",
							"--exclude",
							"node_modules",
							"--exclude",
							"target",
							"--exclude",
							"bin",
							"--exclude",
							"dist",
							"--exclude",
							"coverage",
						},
					})
				end,
				desc = "Find files with fd (excluding .class)",
			},
			{ "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Telescope find buffers" },
			{ "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Telescope help page" },
			{ "<leader>ma", "<cmd>Telescope marks<cr>", desc = "Telescope find marks" },
			{ "<leader>fo", "<cmd>Telescope oldfiles<cr>", desc = "Telescope find oldfiles" },
			{ "<leader>fz", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Telescope find in current buffer" },
			{ "<leader>fw", "<cmd>Telescope live_grep<cr>", desc = "Telescope find in current buffer" },
			{ "<leader>cm", "<cmd>Telescope git_commits<cr>", desc = "Telescope git commits" },
			{ "<leader>fg", "<cmd>Telescope git_status<cr>", desc = "Telescope git status" },
			{
				"<leader>fa",
				"<cmd>Telescope find_files follow=true no_ignore=true hidden=true<cr>",
				desc = "Telescope find all files",
			},
		},
	},
}
