vim.pack.add({
  "https://github.com/folke/which-key.nvim"
})

vim.keymap.set(
  "n",
  "<leader>?",
  function()
    require("which-key").show({ global = false })
  end,
  { desc = "Buffer Local Keymaps (which-key)" }
)
