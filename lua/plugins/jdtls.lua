vim.pack.add({
  "https://github.com/mfussenegger/nvim-jdtls"
})

local jdtls_path = vim.fn.stdpath("data") .. "/mason/packages/jdtls/"
local launcher_jar = vim.fn.glob(jdtls_path .. "plugins/org.eclipse.equinox.launcher_*.jar")
local config_path = jdtls_path .. "config_linux"
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
local workspace_dir = vim.fn.stdpath("data") .. "/jdtls-workspace/" .. project_name

local lombok_path = vim.fn.expand("~") .. "/.local/share/nvim/mason/packages/lombok-nightly/lombok.jar"

local cmd = {
  "jdtls",
  "-data", workspace_dir,
  "-jar", launcher_jar,
  "-configuration", config_path,
  "-Declipse.application=org.eclipse.jdt.ls.core.id1",
  "-Dosgi.bundles.defaultStartLevel=4",
  "-Declipse.product=org.eclipse.jdt.ls.core.product",
  "-Dlog.protocol=true",
  "-Dlog.level=ALL",
  "-Xms1g",
  "--add-modules=ALL-SYSTEM",
  "--add-opens", "java.base/java.util=ALL-UNNAMED",
  "--add-opens", "java.base/java.lang=ALL-UNNAMED",
  "--jvm-arg=-javaagent:" .. lombok_path,
}

vim.api.nvim_create_autocmd("FileType", {
  pattern = "java",
  callback = function()
    require "jdtls".start_or_attach({
      cmd = cmd,
      root_dir = require("jdtls.setup").find_root({ "pom.xml", "build.gradle", ".git", "mvnw", "gradlew" }),
      settings = {
        java = {
          eclipse = {
            downloadSources = true,
          },
          configuration = {
            updateBuildConfiguration = "automatic",
          },
          maven = {
            downloadSources = true,
          },
          implementationsCodeLens = {
            enabled = true,
          },
          referencesCodeLens = {
            enabled = true,
          },
          references = {
            includeDecompiledSources = true,
          },
          format = {
            enabled = true,
          },
        },
      },
      flags = {
        allow_incremental_sync = true,
      },
      init_options = {
        bundles = {},
      },
    })
  end
})
