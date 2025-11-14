return {
  {
    "nvim-java/nvim-java",
  },

  {
    "numToStr/Comment.nvim",
    opts = {},
  },

  {
    "williamboman/mason.nvim",
    opts = function()
      return {
        PATH = "prepend", -- ← change this
        registries = {
          "github:nvim-java/mason-registry",
          "github:mason-org/mason-registry",
        },
      }
    end,
  },

  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls",
          "pyright",
          "html",
          "ts_ls",
          "gopls",
          "cssls",
        },
        automatic_installation = true,
      })
    end,
  },

  {
    "nvimdev/lspsaga.nvim",
    event = "LspAttach",
    config = function()
      require("lspsaga").setup({
        code_action = {
          show_server_name = false,
          extend_gitsigns = false,
          keys = {
            quit = { "q", "<Esc>" },
            exec = { "o", "<CR>", "l" },
          },
        },
        symbol_in_winbar = { enable = false },
        ui = {
          code_action = "",
          title = false,
          border = "rounded",
        },
      })
    end,
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      local on_attach = function(_, bufnr)
        local map = function(lhs, rhs)
          vim.keymap.set("n", lhs, rhs, { buffer = bufnr, silent = true })
        end
        local smap = function(mode, lhs, rhs)
          vim.keymap.set(mode, lhs, rhs, { silent = true })
        end

        smap({ "n", "t" }, "<A-i>", "<cmd>Lspsaga term_toggle<CR>")
        map("K", "<cmd>Lspsaga hover_doc<CR>")
        map("gd", "<cmd>Lspsaga goto_definition<CR>")
        map("gr", "<cmd>Lspsaga finder<CR>")
        map("gt", "<cmd>Lspsaga peek_type_definition<CR>")
        map("gi", "<cmd>Lspsaga finder imp<CR>")
        map("<leader>rn", "<cmd>Lspsaga rename<CR>")
        map("<leader>ca", "<cmd>Lspsaga code_action<CR>")
        map("<leader>cd", "<cmd>Lspsaga show_line_diagnostics<CR>")
        map("<leader>cp", "<cmd>Lspsaga diagnostic_jump_prev<CR>")
        map("<leader>cn", "<cmd>Lspsaga diagnostic_jump_next<CR>")
        map("<leader>wd", "<cmd>Lspsaga show_workspace_diagnostics<CR>")
        smap("n", "<leader>co", "<cmd>Lspsaga outline<CR>")


        vim.keymap.set("n", "<leader>im", function()
          vim.lsp.buf.code_action({
            only = { "source.addMissingImports" },
            apply = true,
          })
        end)
      end

      local lombok_path = vim.fn.expand("~") .. "/.local/share/nvim/mason/packages/lombok-nightly/lombok.jar"
      -- Java
      vim.lsp.config["jdtls"] = {
        cmd = {
          "jdtls",
          "-Declipse.application=org.eclipse.jdt.ls.core.id1",
          "-Dosgi.bundles.defaultStartLevel=4",
          "-Declipse.product=org.eclipse.jdt.ls.core.product",
          "-Dlog.protocol=true",
          "-Dlog.level=ALL",
          "-Xms1g",
          "-Xmx2G",
          "--jvm-arg=-javaagent:" .. lombok_path,
        },
        root_dir = vim.fs.root(0, { ".git", "pom.xml", "mvnw", "gradlew" }),
        on_attach = on_attach,
        settings = {
          java = {
            signatureHelp = {
              enabled = true
            },
            configuration = {
              updateBuildConfiguration = "disabled", -- ← evita que toque .project
            },
            project = {
              resourceFilters = {}, -- ← evita que añada esos filters
            },
          }
        },
      }
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "java",
        callback = function(args)
          vim.lsp.start(vim.lsp.config["jdtls"], { bufnr = args.buf })
        end,
      })

      -- Lua
      vim.lsp.config["lua_ls"] = {
        on_attach = on_attach,
        settings = { Lua = { diagnostics = { globals = { "vim" } } } },
      }
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "lua",
        callback = function(args)
          vim.lsp.start(vim.lsp.config["lua_ls"], { bufnr = args.buf })
        end,
      })

      -- Python
      vim.lsp.config["pyright"] = { on_attach = on_attach }
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "python",
        callback = function(args)
          vim.lsp.start(vim.lsp.config["pyright"], { bufnr = args.buf })
        end,
      })

      -- HTML
      vim.lsp.config["html"] = { on_attach = on_attach }
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "html",
        callback = function(args)
          vim.lsp.start(vim.lsp.config["html"], { bufnr = args.buf })
        end,
      })

      -- JavaScript/TypeScript (ts_ls replaces tsserver)
      vim.lsp.config["ts_ls"] = { on_attach = on_attach }
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "javascript", "typescript", "javascriptreact", "typescriptreact" },
        callback = function(args)
          vim.lsp.start(vim.lsp.config["ts_ls"], { bufnr = args.buf })
        end,
      })

      -- Go
      vim.lsp.config["gopls"] = { on_attach = on_attach }
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "go",
        callback = function(args)
          vim.lsp.start(vim.lsp.config["gopls"], { bufnr = args.buf })
        end,
      })

      -- CSS
      vim.lsp.config["cssls"] = { on_attach = on_attach }
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "css",
        callback = function(args)
          vim.lsp.start(vim.lsp.config["cssls"], { bufnr = args.buf })
        end,
      })

    end,

  }
}
