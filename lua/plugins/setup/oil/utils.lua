local M = {}

local oil_sidebar_win = nil
local oil_target_win = nil

local oil = require("oil")

function M.select()
  local current_win = vim.api.nvim_get_current_win()

  -- Normal Oil window: preserve Oil's default <CR> behavior
  if current_win ~= oil_sidebar_win then
    require("oil.actions").select.callback()
    return
  end

  local entry = oil.get_cursor_entry()
  if not entry then
    return
  end

  if entry.type == "directory" then
    require("oil.actions").select.callback()
    return
  end

  local dir = oil.get_current_dir()
  if not dir then
    return
  end

  if not oil_target_win or not vim.api.nvim_win_is_valid(oil_target_win) then
    for _, win in ipairs(vim.api.nvim_list_wins()) do
      local buf = vim.api.nvim_win_get_buf(win)

      if vim.bo[buf].filetype ~= "oil" then
        oil_target_win = win
        break
      end
    end
  end

  if not oil_target_win or not vim.api.nvim_win_is_valid(oil_target_win) then
    return
  end

  local path = dir .. entry.name

  vim.api.nvim_win_call(oil_target_win, function()
    vim.cmd.edit(vim.fn.fnameescape(path))
  end)
end

function M.close_oil()
  local current_win = vim.api.nvim_get_current_win()

  if oil_sidebar_win
      and vim.api.nvim_win_is_valid(oil_sidebar_win)
      and current_win == oil_sidebar_win then
    vim.api.nvim_win_close(oil_sidebar_win, true)
    oil_sidebar_win = nil
    return
  end

  require("oil.actions").close.callback()
end

function M.toggle_oil_sidebar()
  if oil_sidebar_win and vim.api.nvim_win_is_valid(oil_sidebar_win) then
    vim.api.nvim_win_close(oil_sidebar_win, true)
    oil_sidebar_win = nil
    return
  end

  oil_target_win = vim.api.nvim_get_current_win()

  vim.cmd("topleft vsplit")
  vim.cmd("vertical resize 40")

  oil_sidebar_win = vim.api.nvim_get_current_win()

  oil.open()
end

return M
