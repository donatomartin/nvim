-- Remember last cursor position
-- From reddit user evergreengt
-- Replying on post https://www.reddit.com/r/neovim/comments/1052d98/how_to_save_last_position_in_files/
vim.api.nvim_create_autocmd("BufReadPost", {
  group = vim.api.nvim_create_augroup("LastPlace", {}),
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

-- Create missing directories for real file buffers only
vim.api.nvim_create_autocmd("BufWritePre", {
  group = vim.api.nvim_create_augroup("AutoCreateDirs", { clear = true }),
  desc = "create intermediate directories",
  pattern = "*",
  callback = function(event)
    local buf = event.buf

    -- Skip Oil, terminals, help, quickfix, plugin buffers, etc.
    if vim.bo[buf].buftype ~= "" then
      return
    end

    if vim.bo[buf].filetype == "oil" then
      return
    end

    local file_path = event.match

    -- Skip URI-like buffers: oil://, fugitive://, term://, etc.
    if file_path:match("^%a[%w+.-]*:") then
      return
    end

    local dir_path = vim.fn.fnamemodify(file_path, ":p:h")

    if dir_path == "" or dir_path == "." then
      return
    end

    if not vim.uv.fs_stat(dir_path) then
      vim.fn.mkdir(dir_path, "p")
    end
  end
  ,
})

-- Prevent health from opening a tab
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("CheckhealthFloat", { clear = true }),
  pattern = "checkhealth",
  callback = function(event)
    local health_buf = event.buf
    local health_tab = vim.api.nvim_get_current_tabpage()
    local previous_tabnr = vim.fn.tabpagenr("#")

    vim.schedule(function()
      if not vim.api.nvim_buf_is_valid(health_buf) then
        return
      end

      local tabs = vim.api.nvim_list_tabpages()
      local previous_tab = tabs[previous_tabnr]

      if not previous_tab or not vim.api.nvim_tabpage_is_valid(previous_tab) then
        return
      end

      if previous_tab == health_tab then
        return
      end

      vim.api.nvim_set_current_tabpage(previous_tab)

      local width = math.floor(vim.o.columns * 0.85)
      local height = math.floor(vim.o.lines * 0.8)
      local col = math.floor((vim.o.columns - width) / 2)
      local row = math.floor((vim.o.lines - height) / 1.75) - 2

      local win = vim.api.nvim_open_win(health_buf, true, {
        relative = "editor",
        width = width,
        height = height,
        col = col,
        row = row,
        style = "minimal",
        border = "rounded",
      })

      vim.wo[win].wrap = false
      vim.wo[win].number = false
      vim.wo[win].relativenumber = false

      if vim.api.nvim_tabpage_is_valid(health_tab) then
        vim.api.nvim_set_current_tabpage(health_tab)
        pcall(vim.cmd, "tabclose")
      end

      if vim.api.nvim_tabpage_is_valid(previous_tab) then
        vim.api.nvim_set_current_tabpage(previous_tab)
      end
    end)
  end,
})
