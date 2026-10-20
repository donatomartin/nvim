local function copy_current_path(modifier)
  local value = vim.fn.expand("%" .. modifier)
  vim.fn.setreg("+", value)
  print("Copied: " .. value)
end

local function clearHighlight()
  vim.cmd("noh")
  vim.cmd("echo ''")
end

local function toggleLines()
  vim.opt_local.number = not vim.opt_local.relativenumber:get()
  vim.opt_local.relativenumber = not vim.opt_local.relativenumber:get()
end

local function register_to_quickfix(reg)
  reg = reg or '+' -- Use system clipboard by default; change to '"' for default register
  local reg_content = vim.fn.getreg(reg)

  if reg_content == "" then
    vim.notify("Register " .. reg .. " is empty", vim.log.levels.WARN)
    return
  end

  local entries = {}
  -- Split the register content by lines/newlines
  for line in string.gmatch(reg_content, "[^\r\n]+") do
    -- Trim whitespace or trailing slashes if necessary
    local clean_path = line:gsub("/+$", "")
    if vim.fn.filereadable(clean_path) == 1 or vim.fn.isdirectory(clean_path) == 1 then
      table.insert(entries, { filename = clean_path })
    end
  end

  if #entries == 0 then
    vim.notify("No valid file paths found in register " .. reg, vim.log.levels.INFO)
    return
  end

  vim.fn.setqflist(entries)
  vim.cmd.copen()
end

require("utils").enableMappings({
  { "j",          "gj",                                     desc = "Move down by visual line" },
  { "k",          "gk",                                     desc = "Move up by visual line" },
  { "<C-c>",      ":%y+<cr>",                               desc = "Yank file to system clipboard",  mode = { "n", "v" }, },
  { "<leader>j",  "<cmd>b#<cr>",                            desc = "Switch to alternate buffer" },
  { "<F1>",       "",                                       desc = "F1 is disabled",                 mode = { "n", "v", "i", "t" }, },
  { "<Esc><Esc>", "<C-\\><C-N>",                            desc = "Escape terminal mode",           mode = "t", },
  { "<Esc>",      clearHighlight,                           desc = "Clear search highlight" },
  { "<leader>yy", ":%y+<cr>",                               desc = "Yank file to system clipboard",  mode = { "n", "v" }, },
  { "<leader>yf", function() copy_current_path(":t") end,   desc = "Copy filename" },
  { "<leader>yF", function() copy_current_path(":t:r") end, desc = "Copy filename without extension" },
  { "<leader>yp", function() copy_current_path(":p") end,   desc = "Copy full path" },
  { "<leader>yr", function() copy_current_path(":.") end,   desc = "Copy relative path" },
  { "<leader>tr", toggleLines,                              desc = "Toggle Relative Lines" },
  { "<leader>cq", register_to_quickfix,                     desc = "Register to qflist" }
})
