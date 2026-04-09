-- Remember last cursor position
-- From reddit user evergreengt
-- Replying on post https://www.reddit.com/r/neovim/comments/1052d98/how_to_save_last_position_in_files/
local lastplace = vim.api.nvim_create_augroup("LastPlace", {})
vim.api.nvim_clear_autocmds({ group = lastplace })
vim.api.nvim_create_autocmd("BufReadPost", {
	group = lastplace,
	pattern = { "*" },
	desc = "remember last cursor place",
	callback = function()
		local mark = vim.api.nvim_buf_get_mark(0, '"')
		local lcount = vim.api.nvim_buf_line_count(0)
		if mark[1] > 0 and mark[1] <= lcount then
			pcall(vim.api.nvim_win_set_cursor, 0, mark)
		end
	end,
})

-- Create missing directories
local function create_directory_if_needed()
	local file_path = vim.fn.expand("%:p")
	local dir_path = vim.fn.fnamemodify(file_path, ":h")

	if not vim.loop.fs_stat(dir_path) then
		os.execute("mkdir -p " .. dir_path)
	end
end

local autoCreateDirs = vim.api.nvim_create_augroup("AutoCreateDirs", {})
vim.api.nvim_create_autocmd("BufWritePre", {
  group = autoCreateDirs,
  desc = "create intermediate directories",
	pattern = "*",
	callback = create_directory_if_needed
})
