vim.pack.add({
  "https://github.com/windwp/nvim-autopairs"
})

local opts = {
  fast_wrap = {},
  disable_filetype = { "TelescopePrompt", "vim" },
}

require("nvim-autopairs").setup(opts)

local npairs = require("nvim-autopairs")
local rule = require("nvim-autopairs.rule")
local cond = require("nvim-autopairs.conds")

npairs.add_rules({ rule("<", ">", { "java" }):with_move(cond.after_regex("<")) })
