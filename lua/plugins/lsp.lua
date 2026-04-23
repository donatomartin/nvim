local workspace_diagnostics = function()
	local clients = vim.lsp.get_clients({ bufnr = 0 })

	for _, client in ipairs(clients) do
		if client:supports_method("workspace/diagnostic") then
			vim.lsp.buf.workspace_diagnostics({ client_id = client.id })
		else
			require("workspace-diagnostics").populate_workspace_diagnostics(client, 0)
		end
	end
end

local map = function(mode, lhs, rhs, bufnr)
	if bufnr then
		vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, silent = true })
	else
		vim.keymap.set(mode, lhs, rhs, { silent = true })
	end
end

local on_attach = function(_, bufnr)
	map("n", "<leader>co", "<cmd>Lspsaga outline<cr>")
	map("n", "<leader>cw", "<cmd>Lspsaga winbar_toggle<cr>")

	map("n", "gt", "<cmd>Lspsaga goto_type_definition<cr>", bufnr)
	map("n", "gd", "<cmd>Lspsaga finder def<cr>", bufnr)
	map("n", "gi", "<cmd>Lspsaga finder imp<cr>", bufnr)
	map("n", "gr", "<cmd>Lspsaga finder<cr>", bufnr)
	map("n", "gci", "<cmd>Telescope lsp_incoming_calls<cr>", bufnr)
	map("n", "gco", "<cmd>Telescope lsp_outgoing_calls<cr>", bufnr)

	map("n", "K", "<cmd>Lspsaga hover_doc<cr>", bufnr)
	map("n", "<leader>rn", "<cmd>Lspsaga rename<cr>", bufnr)
	map("n", "<leader>ca", "<cmd>Lspsaga code_action<cr>", bufnr)
	map("n", "<leader>cd", "<cmd>Lspsaga show_cursor_diagnostics<cr>", bufnr)
	map("n", "<leader>cN", "<cmd>Lspsaga diagnostic_jump_prev<cr>", bufnr)
	map("n", "<leader>cn", "<cmd>Lspsaga diagnostic_jump_next<cr>", bufnr)
	map("n", "<leader>cw", "<cmd>Lspsaga show_workspace_diagnostics<cr>", bufnr)
	map("n", "<leader>cx", workspace_diagnostics, bufnr)
end

return {
	{
		"nvimdev/lspsaga.nvim",
		dependencies = {
			"artemave/workspace-diagnostics.nvim",
			"nvim-tree/nvim-web-devicons",
			"neovim/nvim-lspconfig",
		},
		config = function()
			map({ "n", "t" }, "<A-i>", "<cmd>Lspsaga term_toggle<cr>")

      require("lang.lsps").config(on_attach)

			require("lspsaga").setup({
				finder = {
					layout = "float",
					max_height = 0.5,
					left_width = 0.35,
					right_width = 0.55,
					keys = {
						shuttle = "[w",
						toggle_or_open = { "o", "<cr>", "l" },
						vsplit = "s",
						split = "i",
						tabe = "t",
						tabnew = "r",
						quit = { "q", "<Esc>" },
						close = "<C-c>k",
					},
				},
				code_action = {
					show_server_name = false,
					extend_gitsigns = false,
					keys = {
						quit = { "q", "<Esc>" },
						exec = { "o", "<cr>", "l" },
					},
				},
				symbol_in_winbar = { enable = false },
				ui = {
					code_action = "",
					title = false,
					border = "rounded",
				},
			})

			local function saga_highlights()
				vim.api.nvim_set_hl(0, "SagaNormal", { link = "NormalFloat" })
				vim.api.nvim_set_hl(0, "SagaBorder", { link = "FloatBorder" })
			end

			saga_highlights()

			vim.api.nvim_create_autocmd("ColorScheme", {
				callback = saga_highlights,
			})
		end,
	},
}
