vim.pack.add({
  "https://github.com/folke/snacks.nvim"
})

local utils = require "utils"
local snacks = require "snacks"

---@type snacks.Config
snacks.setup({
  terminal = {
    win = {
      position = "float",
      border = "rounded",
    }
  },
  scroll = {
    enabled = true,
  },
  indent = {
    enabled = true,
    animate = {
      enabled = true,
      style = "out", -- Options: "out", "up_down", "down", "up"
    },
  },
  animate = {
    duration = 20, -- ms per step
    easing = "linear",
    fps = 120,     -- frames per second. Global setting for all animations
  },
  input = {
    enabled = true, -- Enhances `ask()`
  },
  picker = {
    enabled = true, -- Enhances `select()`
    layout = {
      preset = "default",
    },
    sources = {
      help = {
        confirm = { "vsplit" },
      },
    },
    actions = {
      ---@param picker snacks.Picker
      opencode_send = function(picker)
        local items = vim.tbl_map(function(item) ---@param item snacks.picker.Item
          return item.file
              and require("opencode").format({ path = item.file, from = item.pos, to = item.end_pos })
              or item.text
        end, picker:selected({ fallback = true }))

        require("opencode").prompt(table.concat(items, ", ") .. " ")
      end,
    },
    win = {
      input = {
        keys = {
          ["<a-a>"] = { "opencode_send", mode = { "n", "i" } },
          ["<c-k>"] = { "preview_scroll_up", mode = { "n", "i" } },
          ["<c-j>"] = { "preview_scroll_down", mode = { "n", "i" } },
        },
      },
    },
  },
})

utils.enableMappings({
  -- Top Pickers & Explorer
  { "<leader><space>", function() Snacks.picker.smart() end,                                   desc = "Smart Find Files" },
  { "<leader>fw",      function() Snacks.picker.grep() end,                                    desc = "Grep" },
  { "<leader>e",       function() Snacks.explorer() end,                                       desc = "File Explorer" },
  -- picker find
  { "<leader>fb",      function() Snacks.picker.buffers() end,                                 desc = "Buffers" },
  { "<leader>fc",      function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "Find Config File" },
  { "<leader>ff",      function() Snacks.picker.files() end,                                   desc = "Find Files" },
  { "<leader>fg",      function() Snacks.picker.git_diff() end,                                desc = "Git Diff (Hunks)" },
  { "<leader>fG",      function() Snacks.picker.git_files() end,                               desc = "Find Git Files" },
  { "<leader>fp",      function() Snacks.picker.projects() end,                                desc = "Projects" },
  { "<leader>fo",      function() Snacks.picker.recent() end,                                  desc = "Recent" },
  { "<leader>fh",      function() Snacks.picker.help() end,                                    desc = "Help Pages" },
  -- picker git
  { "<leader>gb",      function() Snacks.picker.git_branches() end,                            desc = "Git Branches" },
  { "<leader>gl",      function() Snacks.picker.git_log() end,                                 desc = "Git Log" },
  { "<leader>gL",      function() Snacks.picker.git_log_line() end,                            desc = "Git Log Line" },
  { "<leader>gs",      function() Snacks.picker.git_status() end,                              desc = "Git Status" },
  { "<leader>gS",      function() Snacks.picker.git_stash() end,                               desc = "Git Stash" },
  { "<leader>gf",      function() Snacks.picker.git_log_file() end,                            desc = "Git Log File" },
  -- picker gh
  { "<leader>gi",      function() Snacks.picker.gh_issue() end,                                desc = "GitHub Issues (open)" },
  { "<leader>gI",      function() Snacks.picker.gh_issue({ state = "all" }) end,               desc = "GitHub Issues (all)" },
  { "<leader>gp",      function() Snacks.picker.gh_pr() end,                                   desc = "GitHub Pull Requests (open)" },
  { "<leader>gP",      function() Snacks.picker.gh_pr({ state = "all" }) end,                  desc = "GitHub Pull Requests (all)" },
  -- picker search
  { '<leader>s"',      function() Snacks.picker.registers() end,                               desc = "Registers" },
  { '<leader>s/',      function() Snacks.picker.search_history() end,                          desc = "Search History" },
  { "<leader>sa",      function() Snacks.picker.autocmds() end,                                desc = "Autocmds" },
  { "<leader>sb",      function() Snacks.picker.lines() end,                                   desc = "Buffer Lines" },
  { "<leader>sw",      function() Snacks.picker.grep_word() end,                               desc = "Visual selection or word",   mode = { "n", "x" } },
  { "<leader>sB",      function() Snacks.picker.grep_buffers() end,                            desc = "Grep Open Buffers" },
  { "<leader>sc",      function() Snacks.picker.command_history() end,                         desc = "Command History" },
  { "<leader>sC",      function() Snacks.picker.commands() end,                                desc = "Commands" },
  { "<leader>sd",      function() Snacks.picker.diagnostics() end,                             desc = "Diagnostics" },
  { "<leader>sD",      function() Snacks.picker.diagnostics_buffer() end,                      desc = "Buffer Diagnostics" },
  { "<leader>sH",      function() Snacks.picker.highlights() end,                              desc = "Highlights" },
  { "<leader>si",      function() Snacks.picker.icons() end,                                   desc = "Icons" },
  { "<leader>sj",      function() Snacks.picker.jumps() end,                                   desc = "Jumps" },
  { "<leader>sk",      function() Snacks.picker.keymaps() end,                                 desc = "Keymaps" },
  { "<leader>sl",      function() Snacks.picker.loclist() end,                                 desc = "Location List" },
  { "<leader>sm",      function() Snacks.picker.marks() end,                                   desc = "Marks" },
  { "<leader>sM",      function() Snacks.picker.man() end,                                     desc = "Man Pages" },
  { "<leader>sq",      function() Snacks.picker.qflist() end,                                  desc = "Quickfix List" },
  { "<leader>sR",      function() Snacks.picker.resume() end,                                  desc = "Resume" },
  { "<leader>su",      function() Snacks.picker.undo() end,                                    desc = "Undo History" },
  { "<leader>uC",      function() Snacks.picker.colorschemes() end,                            desc = "Colorschemes" },
  -- picker LSP
  { "gd",              function() Snacks.picker.lsp_definitions() end,                         desc = "Goto Definition" },
  { "gD",              function() Snacks.picker.lsp_declarations() end,                        desc = "Goto Declaration" },
  { "gr",              function() Snacks.picker.lsp_references() end,                          nowait = true,                       desc = "References" },
  { "gi",              function() Snacks.picker.lsp_implementations() end,                     desc = "Goto Implementation" },
  { "gy",              function() Snacks.picker.lsp_type_definitions() end,                    desc = "Goto T[y]pe Definition" },
  { "gai",             function() Snacks.picker.lsp_incoming_calls() end,                      desc = "C[a]lls Incoming" },
  { "gao",             function() Snacks.picker.lsp_outgoing_calls() end,                      desc = "C[a]lls Outgoing" },
  { "<leader>ss",      function() Snacks.picker.lsp_symbols() end,                             desc = "LSP Symbols" },
  { "<leader>sS",      function() Snacks.picker.lsp_workspace_symbols() end,                   desc = "LSP Workspace Symbols" },
  { "<M-i>",           function() Snacks.terminal.toggle() end,                                desc = "Toggle Floating Terminal",   mode = { "n", "t", "i" } },
  -- git utilities
  { "<leader>gof",     function() Snacks.gitbrowse() end,                                      desc = "Git Open File on Remote" },
  -- scratches
  { "<leader>.",       function() Snacks.scratch() end,                                        desc = "Toggle Scratch Buffer" },
  { "<leader>,",       function() Snacks.scratch.select() end,                                 desc = "Select Scratch Buffer" },
})
