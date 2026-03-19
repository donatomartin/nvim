if not vim.g.vscode then
return {
  {
    'mbbill/undotree',
    lazy = false,
    keys = {{"<leader>ut", vim.cmd.UndotreeToggle, desc = "Toggle Undo Tree"}}
  }
}
else return {} end
