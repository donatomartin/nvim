dofile(vim.g.base46_cache .. "mason")

return {
  PATH = "skip",
  registries = {
    "github:nvim-java/mason-registry",
    "github:mason-org/mason-registry",
  },
  ui = {
    icons = {
      package_pending = " ",
      package_installed = " ",
      package_uninstalled = " ",
    },
  },

  max_concurrent_installers = 10,
}
