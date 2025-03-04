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
            elements = { "console" }, -- Only include the console in the second layout
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
      -- Java Debug Adapter
      dap.adapters.java = function(callback)
        callback {
          type = "server",
          host = "127.0.0.1",
          port = 5005, -- Must match the port used when launching Java
        }
      end

      -- Java Debug Configurations
      dap.configurations.java = {
        {
          type = "java",
          request = "attach",
          name = "Attach to Java Process",
          hostName = "127.0.0.1",
          port = 5005,
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
