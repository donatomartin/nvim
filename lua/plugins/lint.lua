vim.pack.add({
  "https://github.com/mfussenegger/nvim-lint"
})

require('lint').linters_by_ft = {
  zsh = {'shellcheck'},
  bash = {'shellcheck'},
  sh = {'shellcheck'},
}

vim.keymap.set("n", "<leader>ll", require("lint").try_lint, { desc = "Lint" });
