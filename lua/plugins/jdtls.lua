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

    require "lang".on_attach()
    vim.keymap.set("n", "<leader>co", function()
      require("jdtls").organize_imports()
    end, { desc = "Organize Imports", buffer = true })

    vim.keymap.set("n", "<leader>crv", function()
      require("jdtls").extract_variable()
    end, { desc = "Extract variable", buffer = true })

    vim.keymap.set("v", "<leader>crv", function()
      require("jdtls").extract_variable(true)
    end, { desc = "Extract variable", buffer = true })

    vim.keymap.set("n", "<leader>crc", function()
      require("jdtls").extract_constant()
    end, { desc = "Extract constant", buffer = true })

    vim.keymap.set("v", "<leader>crc", function()
      require("jdtls").extract_constant(true)
    end, { desc = "Extract constant", buffer = true })

    vim.keymap.set("v", "<leader>crm", function()
      require("jdtls").extract_method(true)
    end, { desc = "Extract method", buffer = true })
  end
})
