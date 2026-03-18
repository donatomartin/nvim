return {
  {
    "windwp/nvim-autopairs",
    opts = {
      fast_wrap = {},
      disable_filetype = { "TelescopePrompt", "vim" },
    },
    config = function(_, opts)
      require("nvim-autopairs").setup(opts)
      local cmp_autopairs = require "nvim-autopairs.completion.cmp"
      require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
    end,
  },
  {
    "L3MON4D3/LuaSnip",
    opts = { history = true, updateevents = "TextChanged,TextChangedI" },
    config = function(_, opts)
      require("luasnip").config.set_config(opts)
      require("luasnip.loaders.from_snipmate").load()
      require("luasnip.loaders.from_snipmate").lazy_load { paths = vim.g.snipmate_snippets_path or "" }
      vim.api.nvim_create_autocmd("InsertLeave", {
        callback = function()
          if require("luasnip").session.current_nodes[vim.api.nvim_get_current_buf()]
              and not require("luasnip").session.jump_active
          then
            require("luasnip").unlink_current()
          end
        end,
      })
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "windwp/nvim-autopairs",
      "L3MON4D3/LuaSnip",
      "rafamadriz/friendly-snippets"
    },

    opts = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      return {

        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },

        mapping = {
          -- Open completion menu manually
          ["<C-Space>"] = cmp.mapping.complete(),

          -- Close menu
          ["<C-e>"] = cmp.mapping.close(),

          -- Move through menu items
          ["<C-n>"] = cmp.mapping.select_next_item(),
          ["<C-p>"] = cmp.mapping.select_prev_item(),

          -- Scroll docs in the menu
          ["<C-j>"] = cmp.mapping.scroll_docs(4),
          ["<C-k>"] = cmp.mapping.scroll_docs(-4),

          -- Confirm and insert selected
          ["<CR>"] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Insert, select = true }),

          -- Snippet + tab behavior
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),

          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        },

        formatting = {
          fields = { "kind", "abbr", "menu" },

          format = function(entry, item)
            local kind_icons = {
              Text = "",
              Method = "",
              Function = "󰡱",
              Constructor = "󰒓",
              Field = "",
              Variable = "󰫧",
              Class = "ﴯ",
              Interface = "",
              Module = "",
              Property = "ﰠ",
              Unit = "",
              Value = "󰎠",
              Enum = "",
              Keyword = "󰌋",
              Snippet = "",
              Color = "",
              File = "",
              Reference = "",
              Folder = "",
              EnumMember = "",
              Constant = "",
              Struct = "",
              Event = "",
              Operator = "+",
              TypeParameter = "*",
            }

            item.kind = (kind_icons[item.kind] or "") .. " " .. item.kind
            return item
          end,
        },
        sources = {
          { name = "nvim_lua", priority = 5 },
          { name = "nvim_lsp", priority = 4 },
          { name = "path", priority = 3 },
          { name = "luasnip", prioriry = 2 },
          { name = "buffer", priority = 1 },
        },
      }
    end
  }

}
