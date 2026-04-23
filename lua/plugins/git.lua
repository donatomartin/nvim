return {
	{
		"lewis6991/gitsigns.nvim",
		lazy = false, -- ensure it loads immediately
		config = function()
			require("gitsigns").setup({
				signs = {
					add = { text = "│", hl = "GitSignsAdd" },
					change = { text = "│", hl = "GitSignsChange" },
					delete = { text = "󰍵", hl = "GitSignsDelete" },
					topdelete = { text = "󰍵", hl = "GitSignsDelete" },
					changedelete = { text = "󰍵", hl = "GitSignsChange" },
					untracked = { text = "│", hl = "GitSignsAdd" },
				},
				signcolumn = true,
				numhl = false,
				linehl = false,
				word_diff = false,

				-- current_line_blame = true,
				-- current_line_blame_opts = {
				--   virt_text = true,
				--   virt_text_pos = "eol",
				--   delay = 300,
				-- },
				-- current_line_blame_formatter = "  <author>, <author_time:%R> • <summary>",
			})
		end,
		keys = {
			{ "<leader>gdd", "<cmd>Gitsigns diffthis<cr>" },
			{ "<leader>gdD", "<cmd>Gitsigns diffthis HEAD<cr>" },
			{ "<leader>gds", "<cmd>Gitsigns diffthis --staged<cr>" },
			{ "<leader>ghd", "<cmd>Gitsigns preview_hunk_inline<cr>" },
			{ "<leader>ghp", "<cmd>Gitsigns preview_hunk<cr>" },
			{ "<leader>ghs", "<cmd>Gitsigns stage_hunk<cr>" },
			{ "<leader>ghs", "<cmd>Gitsigns reset_hunk<cr>" },
			{ "<leader>ghn", "<cmd>Gitsigns next_hunk<cr>" },
			{ "<leader>ghN", "<cmd>Gitsigns next_hunk<cr>" },
			{ "<leader>glb", "<cmd>Gitsigns blame_line<cr>" },
			{ "<leader>gbr", "<cmd>Gitsigns reset_buffer<cr>" },
		},
	},

	{
		"tpope/vim-fugitive",
		cmd = { "Git", "G", "Gdiffsplit", "Gvdiffsplit" },
		keys = {
			{ "<leader>gbb", "<cmd>G blame<cr>" },
		},
	},
}
