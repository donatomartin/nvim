local dapui = require("dapui")
local dapnvim = require("dap")
local utils = require("utils")

dapui.setup({
  layouts = {
    {
      elements = { "scopes", "breakpoints", "stacks", "watches" },
      size = 40,
      position = "right",
    },
    {
      elements = { "repl", "console" }, -- Only include the console in the second layout
      size = 10,                        -- Adjust the size for the console pane
      position = "bottom",              -- Position the console at the bottom
    },
  },
})

vim.fn.sign_define("DapBreakpointCondition", {
  text = "●",
  texthl = "DapBreakpointCondition",
  linehl = "",
  numhl = "",
})

vim.fn.sign_define("DapBreakpoint", {
  text = "●",
  texthl = "DapBreakpoint",
  linehl = "",
  numhl = "",
})

-- PYTHON
dapnvim.adapters.python = function(callback, config)
  if config.request == "attach" then
    local port = config.connect and config.connect.port or 5678
    local host = config.connect and config.connect.host or "127.0.0.1"
    callback {
      type = "server",
      host = host,
      port = port,
      options = {
        source_file_map = { ["<path_in_container>"] = "<path_on_host>" }, -- Only needed for remote debugging
      },
    }
  else
    callback {
      type = "executable",
      command = "python",
      args = { "-m", "debugpy.adapter" },
    }
  end
end
dapnvim.configurations.python = {
  {
    type = "python",
    request = "launch",
    name = "Launch File",
    program = "${file}", -- Run the current file
    pythonPath = function()
      return "python"    -- Modify this if using virtualenv or a specific interpreter
    end,
  },
}

-- JAVA
dapnvim.configurations.java = {
  {
    type = "java",
    name = "Debug (Attach)",
    request = "attach",
    hostName = "127.0.0.1",
    port = 5005,
  },
}

local function cleanup_dap_terminal()
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_valid(buf) then
      local name = vim.api.nvim_buf_get_name(buf)

      if vim.bo[buf].buftype == "terminal"
          and (name:match("dap") or name:match("java")) then
        pcall(vim.api.nvim_buf_delete, buf, { force = true })
      end
    end
  end
end

-- Automatically open/close dapui
dapnvim.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dapnvim.listeners.before.event_terminated["dapui_config"] = function()
  -- dapui.close()
end
dapnvim.listeners.before.event_exited["dapui_config"] = function()
  -- dapui.close()
end

utils.enableMappings(
  {
    { "<F5>",        function() dapnvim.continue() end,  desc = "Start debugging", },
    { "<leader>dd",  function() dapnvim.step_over() end, desc = "Step Over", },
    { "<leader>di",  function() dapnvim.step_into() end, desc = "Step Into", },
    { "<leader>do",  function() dapnvim.step_out() end,  desc = "Step Out", },
    { "<leader>du",  function() dapui.toggle() end,      desc = "Toggle Debug UI", },
    { "<leader>dct", cleanup_dap_terminal,               desc = "Cleanup dap terminal", },
    {
      "<leader>dw",
      function()
        local expression = vim.fn.input "Expression to watch: "
        dapnvim.elements.watches.add(expression)
      end,
      desc = "Add expression to watch",
    },
    {
      "<leader>dcb",
      function()
        local condition = vim.fn.input "Breakpoint condition: "
        dapnvim.set_breakpoint(condition)
      end,
      desc = "Set conditional breakpoint",
    },
    { "<leader>db", function() dapnvim.toggle_breakpoint() end, desc = "Toggle Breakpoint", },
    { "<leader>dt", function() dapnvim.terminate() end,         desc = "Terminate debug session", },
    { "<leader>dr", function() dapnvim.run_to_cursor() end,     desc = "Run to cursor", },
  }
)
