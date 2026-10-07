local utils = require("utils")
local neogit = require("neogit")

neogit.setup()

utils.enableMappings({
  { "<leader>gg", neogit.open, desc = "Neogit open" }
})
