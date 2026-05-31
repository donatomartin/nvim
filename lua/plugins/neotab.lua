vim.pack.add({
  "https://github.com/kawre/neotab.nvim"
})

local opts = {
  tabkey = "<Tab>",
  reverse_key = "<S-Tab>",
  act_as_tab = true,
  behavior = "nested",
  pairs = {
    { open = "(", close = ")" },
    { open = "[", close = "]" },
    { open = "{", close = "}" },
    { open = "'", close = "'" },
    { open = '"', close = '"' },
    { open = "`", close = "`" },
    { open = "<", close = ">" },
  },
  exclude = {},
  smart_punctuators = {
    enabled = false,
    semicolon = {
      enabled = false,
      ft = { "cs", "c", "cpp", "java" },
    },
    escape = {
      enabled = false,
      triggers = {},
    },
  },
}

require "neotab".setup(opts)
