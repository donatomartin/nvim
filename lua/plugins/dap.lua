return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",
    },
    config = function()
      local dap = require "dap"
      local dapui = require "dapui"

      -- Set up UI
      dapui.setup {
        layouts = {
          {
            elements = { "scopes", "breakpoints", "stacks", "watches" },
            size = 0.25,
            position = "right",
          },
          {
            elements = { "repl", "console" }, -- Only include the console in the second layout
            size = 0.25, -- Adjust the size for the console pane
            position = "bottom", -- Position the console at the bottom
          },
        },
      }
      vim.fn.sign_define("DapBreakpoint", {
        text = "●",
        texthl = "DapBreakpoint",
        linehl = "",
        numhl = "",
      })

      -- PYTHON
      -- Python Debug Adapter
      dap.adapters.python = function(callback, config)
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

      -- Python Debug Configurations
      dap.configurations.python = {
        {
          type = "python",
          request = "launch",
          name = "Launch File",
          program = "${file}", -- Run the current file
          pythonPath = function()
            return "python" -- Modify this if using virtualenv or a specific interpreter
          end,
        },
      }

      -- Automatically open/close dapui
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        -- dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        -- dapui.close()
      end
    end,

    -- Keybindings under lazy keys
    keys = {
      {
        "<F5>",
        function()
          require("dap").continue()
        end,
        desc = "Start debugging",
      },
      {
        "<leader>dd",
        function()
          require("dap").step_over()
        end,
        desc = "Step Over",
      },
      {
        "<leader>di",
        function()
          require("dap").step_into()
        end,
        desc = "Step Into",
      },
      {
        "<leader>do",
        function()
          require("dap").step_out()
        end,
        desc = "Step Out",
      },
      {
        "<leader>du",
        function()
          require("dapui").toggle()
        end,
        desc = "Toggle Debug UI",
      },
      {
        "<leader>dw",
        function()
          local expression = vim.fn.input "Expression to watch: "
          require("dapui").elements.watches.add(expression)
        end,
        desc = "Add expression to watch",
      },
      {
        "<leader>dcb",
        function()
          local condition = vim.fn.input "Breakpoint condition: "
          require("dap").set_breakpoint(condition)
        end,
        desc = "Set conditional breakpoint",
      },
      {
        "<leader>db",
        function()
          require("dap").toggle_breakpoint()
        end,
        desc = "Toggle Breakpoint",
      },
      {
        "<leader>dt",
        function()
          require("dap").terminate()
        end,
        desc = "Terminate debug session",
      },
      {
        "<leader>dr",
        function()
          require("dap").run_to_cursor()
        end,
        desc = "Run to cursor",
      },
    },
  },
}
