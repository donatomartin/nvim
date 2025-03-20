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

      -- JAVA
      -- Java Debug Adapter
      -- Configurations already handled by nvim-java plugin
      dap.adapters.java = function(callback)
        callback {
          type = "server",
          host = "127.0.0.1",
          port = 5005, -- Must match the port used when launching Java
        }
      end

      -- GO (Delve)
      dap.adapters.delve = {
        type = "server",
        port = "38697",
        executable = {
          command = "dlv",
          args = { "dap", "--listen=127.0.0.1:38697", "--log", "--log-output=debugger,stdout,stderr" },
        },
      }

      dap.configurations.go = {
        {
          type = "delve",
          request = "launch",
          name = "Debug with StdOut",
          program = "${file}",
          args = {}, -- You can pass CLI arguments if needed
          console = "integratedTerminal", -- Ensure it uses Neovim's terminal
          output = "integratedTerminal", -- Redirect stdout/stderr to terminal
          dlvToolPath = vim.fn.exepath "dlv", -- Ensure Delve is found
        },
        {
          type = "delve",
          request = "attach",
          name = "Attach to Process",
          processId = require("dap.utils").pick_process,
          console = "integratedTerminal",
          output = "integratedTerminal",
        },
      }

      -- Keybindings
      vim.keymap.set("n", "<F5>", function()
        dap.continue()
      end, { desc = "Start debugging" })
      vim.keymap.set("n", "<F10>", function()
        dap.step_over()
      end, { desc = "Step Over" })
      vim.keymap.set("n", "<F11>", function()
        dap.step_into()
      end, { desc = "Step Into" })
      vim.keymap.set("n", "<F12>", function()
        dap.step_out()
      end, { desc = "Step Out" })
      vim.keymap.set("n", "<leader>db", function()
        dap.toggle_breakpoint()
      end, { desc = "Toggle Breakpoint" })
      vim.keymap.set("n", "<leader>dr", function()
        dap.repl.open()
      end, { desc = "Open REPL" })
      vim.keymap.set("n", "<leader>du", function()
        dapui.toggle()
      end, { desc = "Toggle Debug UI" })
      vim.keymap.set("n", "<leader>dw", function()
        local expression = vim.fn.input "Expression to watch: "
        require("dapui").elements.watches.add(expression)
      end, { desc = "Add expression to watch" })
      vim.keymap.set("n", "<leader>dcb", function()
        local condition = vim.fn.input "Breakpoint condition: "
        require("dap").set_breakpoint(condition)
      end, { desc = "Set conditional breakpoint" })

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
  },
}
