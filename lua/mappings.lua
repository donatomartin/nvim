local map = vim.keymap.set

map({"n","v"}, "<leader>y", ":%y+<cr>", { desc = "Yank file to system clipboard" })
map({"n","v"}, "<C-c>", ":%y+<cr>", { desc = "Yank file to system clipboard" })
map("n", "<Esc>", ":noh<cr>", { desc = "Clear search hl" })
map("t", "<Esc><Esc>", "<C-\\><C-N>", { desc = "Escape terminal mode" })
map("n", ";", ":!")
map({"n", "v", "i", "t"}, "<F1>", "", { desc = "F1 is disabled" })


-- VSCode Mappings
if vim.g.vscode then

	-- :b  → editor previo
	vim.cmd([[
    cabbrev <expr> b getcmdtype() == ':' && getcmdline() == 'b'
      \ ? 'lua vim.fn.VSCodeNotify("workbench.action.quickOpenPreviousRecentlyUsedEditor")'
      \ : 'b'
  ]])

	-- togglear terminal
	vim.keymap.set({ "n", "i" }, "<C-j>", function()
		vim.fn.VSCodeNotify("workbench.action.terminal.toggleTerminal")
	end, { noremap = true, silent = true })

	-- ver diagnósticos flotantes
	vim.keymap.set("n", "<leader>cd", function()
		vim.fn.VSCodeNotify("editor.action.showHover")
	end, { noremap = true, silent = true })

	-- ver diagnósticos
	vim.keymap.set("n", "<leader>pd", function()
		vim.fn.VSCodeNotify("workbench.actions.view.problems")
	end, { noremap = true, silent = true })

	-- ir a implementación
	vim.keymap.set("n", "gi", function()
		vim.fn.VSCodeNotify("editor.action.goToImplementation")
	end, { noremap = true, silent = true })

	vim.keymap.set("n", "<leader>fw", function()
		vim.fn.VSCodeNotify("code-telescope.fuzzy.wsText")
	end, { noremap = true, silent = true })

	vim.keymap.set("n", "<leader>ff", function()
		vim.fn.VSCodeNotify("code-telescope.fuzzy.file")
	end, { noremap = true, silent = true })

	vim.keymap.set("n", "<leader>a", function()
		vim.fn.VSCodeNotify("code-telescope.harpoon.addFile")
	end, { noremap = true, silent = true })
	vim.keymap.set("n", "<leader>h", function()
		vim.fn.VSCodeNotify("code-telescope.harpoon.editMark")
	end, { noremap = true, silent = true })

	vim.keymap.set("n", "<leader>1", function()
		vim.fn.VSCodeNotify("code-telescope.harpoon.gotoFile1")
	end, { noremap = true, silent = true })
	vim.keymap.set("n", "<leader>2", function()
		vim.fn.VSCodeNotify("code-telescope.harpoon.gotoFile2")
	end, { noremap = true, silent = true })
	vim.keymap.set("n", "<leader>3", function()
		vim.fn.VSCodeNotify("code-telescope.harpoon.gotoFile3")
	end, { noremap = true, silent = true })
	vim.keymap.set("n", "<leader>4", function()
		vim.fn.VSCodeNotify("code-telescope.harpoon.gotoFile4")
	end, { noremap = true, silent = true })
	vim.keymap.set("n", "<leader>5", function()
		vim.fn.VSCodeNotify("code-telescope.harpoon.gotoFile5")
	end, { noremap = true, silent = true })
	vim.keymap.set("n", "<leader>6", function()
		vim.fn.VSCodeNotify("code-telescope.harpoon.gotoFile6")
	end, { noremap = true, silent = true })
	vim.keymap.set("n", "<leader>7", function()
		vim.fn.VSCodeNotify("code-telescope.harpoon.gotoFile7")
	end, { noremap = true, silent = true })
	vim.keymap.set("n", "<leader>8", function()
		vim.fn.VSCodeNotify("code-telescope.harpoon.gotoFile8")
	end, { noremap = true, silent = true })
	vim.keymap.set("n", "<leader>9", function()
		vim.fn.VSCodeNotify("code-telescope.harpoon.gotoFile9")
	end, { noremap = true, silent = true })
end
