-- undotree.lua

return {
  {
    'mbbill/undotree',
    lazy = false,
    keys = {{"<leader><F5>", vim.cmd.UndotreeToggle, desc = "Toggle Undo Tree"}}
  }
}
