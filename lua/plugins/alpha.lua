return {
  {
    "goolord/alpha-nvim",
    event = "VimEnter",
    enabled = true,
    config = function()
      local dashboard_theme = require "alpha.themes.dashboard"

      -- Center vertically
      local header_lines = #dashboard_theme.section.header.val
      local total_lines = vim.o.lines
      local pad_top = math.floor((total_lines - header_lines) / 2.5) 

      -- Layout
      dashboard_theme.opts.layout = {
        { type = "padding", val = pad_top },
        dashboard_theme.section.header,
        -- { type = "padding", val = 2 },
        -- dashboard_theme.section.buttons,
        -- { type = "padding", val = 1 },
        -- dashboard_theme.section.footer,
      }

      -- Header Section
      local logo = [[
 ██████   █████              ███                 
░░██████ ░░███              ░░░                  
 ░███░███ ░███  █████ █████ ████  █████████████  
 ░███░░███░███ ░░███ ░░███ ░░███ ░░███░░███░░███ 
 ░███ ░░██████  ░███  ░███  ░███  ░███ ░███ ░███ 
 ░███  ░░█████  ░░███ ███   ░███  ░███ ░███ ░███ 
 █████  ░░█████  ░░█████    █████ █████░███ █████
░░░░░    ░░░░░    ░░░░░    ░░░░░ ░░░░░ ░░░ ░░░░░ 

                            by Donato A. Martín
  ]]
      dashboard_theme.section.header.val = vim.split(logo, "\n")
      dashboard_theme.section.header.opts.hl = "AlphaHeaderGreen"
      vim.api.nvim_set_hl(0, "AlphaHeaderGreen", { fg = "#50fa7b", bold = true })

      -- Buttons Section
      dashboard_theme.section.buttons.val = {
        dashboard_theme.button("<leader> ff", " Find file", "<cmd>Telescope find_files <CR>"),
        dashboard_theme.button("<leader> fw", " Find text", "<cmd>Telescope live_grep <CR>"),
        dashboard_theme.button("<leader> fo", " Recent files", "<cmd>Telescope oldfiles <CR>"),
        dashboard_theme.button(
          "<leader> ql",
          " Load Last Session",
          "<cmd>lua require('persistence').load({ last = true }) <CR>"
        ),
        dashboard_theme.button("n", " New file", "<cmd>ene <BAR> startinsert <CR>"),
        dashboard_theme.button("<leader> qq", " Close", "<cmd>q <CR>"),
        -- Config nvim (cd to nvim C:\Users\Donato\AppData\Local\nvim) and open init.lua)
        dashboard_theme.button(
          "<leader> cn",
          " Config",
          "<cmd>edit $MYVIMRC <CR> <cmd>cd " .. vim.fn.stdpath "config" .. " <CR>"
        ),
      }
      dashboard_theme.section.buttons.opts.hl = "AlphaButtons"

      -- Lazy Loading
      if vim.o.filetype == "lazy" then
        vim.cmd.close()
        vim.api.nvim_create_autocmd("User", {
          once = true,
          pattern = "AlphaReady",
          callback = function()
            require("lazy").show()
          end,
        })
      end

      -- Set the dashbaord
      require("alpha").setup(dashboard_theme.opts)

      -- Draw Footer After Startup
      vim.api.nvim_create_autocmd("User", {
        once = true,
        pattern = "LazyVimStarted",
        callback = function()
          local stats = require("lazy").stats()
          local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)

          -- Footer
          dashboard_theme.section.footer.val = "⚡ Neovim loaded "
            .. stats.loaded
            .. "/"
            .. stats.count
            .. " plugins in "
            .. ms
            .. "ms"
          pcall(vim.cmd.AlphaRedraw)
          dashboard_theme.section.footer.opts.hl = "AlphaFooter"
        end,
      })
    end,
  },
}
