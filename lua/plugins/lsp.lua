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

local on_attach = function(_, bufnr)
	local map = function(lhs, rhs)
		vim.keymap.set("n", lhs, rhs, { buffer = bufnr, silent = true })
	end

	local smap = function(mode, lhs, rhs)
		vim.keymap.set(mode, lhs, rhs, { silent = true })
	end

	smap({ "n", "t" }, "<A-i>", "<cmd>Lspsaga term_toggle<CR>")
	smap("n", "<leader>co", "<cmd>Lspsaga outline<CR>")
	smap("n", "<leader>cw", "<cmd>Lspsaga winbar_toggle<CR>")

	map("gt", "<cmd>Lspsaga goto_type_definition<CR>")
	map("gd", "<cmd>Lspsaga finder def<CR>")
	map("gi", "<cmd>Lspsaga finder imp<CR>")
	map("gr", "<cmd>Lspsaga finder<CR>")
	map("gci", "<cmd>Telescope lsp_incoming_calls<CR>")
	map("gco", "<cmd>Telescope lsp_outgoing_calls<CR>")

	map("K", "<cmd>Lspsaga hover_doc<CR>")
	map("<leader>rn", "<cmd>Lspsaga rename<CR>")
	map("<leader>ca", "<cmd>Lspsaga code_action<CR>")
	map("<leader>cd", "<cmd>Lspsaga show_cursor_diagnostics<CR>")
	map("<leader>cN", "<cmd>Lspsaga diagnostic_jump_prev<CR>")
	map("<leader>cn", "<cmd>Lspsaga diagnostic_jump_next<CR>")
	map("<leader>cw", "<cmd>Lspsaga show_workspace_diagnostics<CR>")
	map("<leader>cx", workspace_diagnostics)
end

return {
	{
		"nvimdev/lspsaga.nvim",
		event = "LspAttach",
		dependencies = {
			"artemave/workspace-diagnostics.nvim",
			"nvim-treesitter/nvim-treesitter",
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			require("lspsaga").setup({
				finder = {
					layout = "float",
					max_height = 0.5,
					left_width = 0.35,
					right_width = 0.55,
					keys = {
						shuttle = "[w",
						toggle_or_open = { "o", "<CR>", "l" },
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
						exec = { "o", "<CR>", "l" },
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
	{
		"neovim/nvim-lspconfig",
		config = function()
			local lombok_path = vim.fn.expand("~") .. "/.local/share/nvim/mason/packages/lombok-nightly/lombok.jar"

			-- Java
			vim.lsp.config["jdtls"] = {
				cmd = {
					"jdtls",
					"-Declipse.application=org.eclipse.jdt.ls.core.id1",
					"-Dosgi.bundles.defaultStartLevel=4",
					"-Declipse.product=org.eclipse.jdt.ls.core.product",
					"-Dlog.protocol=true",
					"-Dlog.level=ALL",
					"-Xms1g",
					"-Xmx2G",
					"--jvm-arg=-javaagent:" .. lombok_path,
				},
				root_dir = vim.fs.root(0, { ".git", "pom.xml", "mvnw", "gradlew", ".project" }),
				on_attach = on_attach,
				settings = {
					java = {
						signatureHelp = {
							enabled = true,
						},
						configuration = {
							updateBuildConfiguration = "disabled", -- ← evita que toque .project
						},
						project = {
							resourceFilters = {}, -- ← evita que añada esos filters
						},
					},
				},
			}
			vim.api.nvim_create_autocmd("FileType", {
				pattern = "java",
				callback = function(args)
					vim.lsp.start(vim.lsp.config["jdtls"], { bufnr = args.buf })
				end,
			})

			vim.lsp.config["vtsls"] = {
				on_attach = on_attach,
				root_dir = vim.fs.root(0, {
					"tsconfig.json",
					"jsconfig.json",
					"package.json",
					".git",
				}),
			}

			vim.api.nvim_create_autocmd("FileType", {
				pattern = { "javascript", "typescript", "javascriptreact", "typescriptreact" },
				callback = function(args)
					vim.lsp.start(vim.lsp.config["vtsls"], { bufnr = args.buf })
				end,
			})

			-- Lua
			vim.lsp.config["lua_ls"] = {
				on_attach = on_attach,
				settings = { Lua = { diagnostics = { globals = { "vim" } } } },
			}
			vim.api.nvim_create_autocmd("FileType", {
				pattern = "lua",
				callback = function(args)
					vim.lsp.start(vim.lsp.config["lua_ls"], { bufnr = args.buf })
				end,
			})

			-- Python
			vim.lsp.config["pyright"] = { on_attach = on_attach }
			vim.api.nvim_create_autocmd("FileType", {
				pattern = "python",
				callback = function(args)
					vim.lsp.start(vim.lsp.config["pyright"], { bufnr = args.buf })
				end,
			})

			-- HTML
			vim.lsp.config["html"] = { on_attach = on_attach }
			vim.api.nvim_create_autocmd("FileType", {
				pattern = "html",
				callback = function(args)
					vim.lsp.start(vim.lsp.config["html"], { bufnr = args.buf })
				end,
			})

			-- Go
			vim.lsp.config["gopls"] = { on_attach = on_attach }
			vim.api.nvim_create_autocmd("FileType", {
				pattern = "go",
				callback = function(args)
					vim.lsp.start(vim.lsp.config["gopls"], { bufnr = args.buf })
				end,
			})

			-- CSS
			vim.lsp.config["cssls"] = { on_attach = on_attach }
			vim.api.nvim_create_autocmd("FileType", {
				pattern = "css",
				callback = function(args)
					vim.lsp.start(vim.lsp.config["cssls"], { bufnr = args.buf })
				end,
			})

			-- Nix (solo nixd)
			vim.lsp.config["nixd"] = {
				on_attach = on_attach,
				root_dir = vim.fs.root(0, { "flake.nix", ".git" }),
				settings = {
					nixpkgs = {
						expr = "import <nixpkgs> {}",
					},
				},
			}
			vim.api.nvim_create_autocmd("FileType", {
				pattern = "nix",
				callback = function(args)
					vim.lsp.start(vim.lsp.config["nixd"], { bufnr = args.buf })
				end,
			})

			-- Latex
			vim.lsp.config["ltex_plus"] = { on_attach = on_attach }
			vim.api.nvim_create_autocmd("FileType", {
				pattern = "tex",
				callback = function(args)
					vim.lsp.start(vim.lsp.config["ltex_plus"], { bufnr = args.buf })
				end,
			})
		end,
	},
}
