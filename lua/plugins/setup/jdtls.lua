vim.pack.add({
  "https://github.com/mfussenegger/nvim-jdtls"
})

local utils = require("utils")
local jdtls = require("jdtls")

--- Variables
local data = vim.fn.stdpath("data")
local root_dir = require("jdtls.setup").find_root({ "pom.xml", "build.gradle", ".git", "mvnw", "gradlew" })
local jdtls_path = data .. "/mason/packages/jdtls/"
local lombok_path = data .. "/mason/packages/lombok-nightly/lombok.jar"
local launcher_jar = vim.fn.glob(jdtls_path .. "plugins/org.eclipse.equinox.launcher_*.jar")
local config_path = jdtls_path .. "config_linux"
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
local workspace_dir = data .. "/jdtls-workspace/" .. project_name
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
local bundles = vim.split(
  vim.fn.glob(
    data ..
    "/mason/packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar"
  ),
  "\n"
)
-- Generate default capabilities and inject workspace file operations
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.workspace = capabilities.workspace or {}
capabilities.workspace.fileOperations = {
  didCreate = true,
  willCreate = true,
  didRename = true,
  willRename = true,
  didDelete = true,
  willDelete = true,
}

--- Go to test function
local function goto_test_or_source()
  local file = vim.api.nvim_buf_get_name(0)

  local source_root = "/src/main/java/"
  local test_root = "/src/test/java/"

  local target

  if file:find(test_root, 1, true) then
    -- Test -> Source
    target = file
        :gsub(test_root, source_root)
        :gsub("Test%.java$", ".java")
  elseif file:find(source_root, 1, true) then
    -- Source -> Test
    target = file
        :gsub(source_root, test_root)
        :gsub("%.java$", "Test.java")
  else
    vim.notify("Not a Java source/test file", vim.log.levels.WARN)
    return
  end

  vim.fn.mkdir(vim.fn.fnamemodify(target, ":h"), "p")
  vim.cmd.edit(target)
end

-- Start jdtls
local function start_jdtls()
  jdtls.setup_dap({
    hotcodereplace = "auto",
  })

  jdtls.start_or_attach({
    cmd = cmd,
    root_dir = root_dir,
    capabilities = capabilities,
    settings = {
      java = {
        completion = {
          favoriteStaticMembers = {
            -- JUnit 5
            "org.junit.jupiter.api.Assertions.*",
            "org.junit.jupiter.api.Assumptions.*",
            "org.junit.jupiter.params.provider.Arguments.*",

            -- AssertJ
            "org.assertj.core.api.Assertions.*",

            -- Mockito
            "org.mockito.Mockito.*",
            "org.mockito.ArgumentMatchers.*",
            "org.mockito.BDDMockito.*",
            "org.mockito.Answers.*",

            -- Hamcrest
            "org.hamcrest.Matchers.*",

            -- Spring MockMvc
            "org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*",
            "org.springframework.test.web.servlet.result.MockMvcResultMatchers.*",
            "org.springframework.test.web.servlet.result.MockMvcResultHandlers.*",

            -- Spring Security Test
            "org.springframework.security.test.web.servlet.request.SecurityMockMvcRequestPostProcessors.*",

            -- RestTemplate tests
            "org.springframework.test.web.client.match.MockRestRequestMatchers.*",
            "org.springframework.test.web.client.response.MockRestResponseCreators.*",

            -- Spring REST Docs
            "org.springframework.restdocs.request.RequestDocumentation.*",
            "org.springframework.restdocs.payload.PayloadDocumentation.*",
            "org.springframework.restdocs.operation.preprocess.Preprocessors.*",
            "org.springframework.restdocs.mockmvc.MockMvcRestDocumentation.*",
          }
        },
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
      bundles = bundles,
    },
  })

  require "lang".on_attach()

  utils.enableMappings({
    { "<leader>t",   goto_test_or_source,                         desc = "Go to test/source", buffer = true },
    { "<leader>co",  jdtls.organize_imports,     desc = "Organize imports",  buffer = true },
    { "<leader>crv", jdtls.extract_variable,     desc = "Extract variable",  buffer = true },
    { "<leader>crc", jdtls.extract_constant,     desc = "Extract constant",  buffer = true },
    { "<leader>crm", jdtls.extract_method,       desc = "Extract method",    buffer = true },
    { "<leader>crv", function() jdtls.extract_variable(true) end, desc = "Extract variable",  buffer = true, mode = "v", },
    { "<leader>crc", function() jdtls.extract_constant(true) end, desc = "Extract constant",  buffer = true, mode = "v", },
    { "<leader>crm", function() jdtls.extract_method(true) end,   desc = "Extract method",    buffer = true, mode = "v", },
  })
end

vim.api.nvim_create_autocmd("FileType", {
  pattern = "java",
  callback = start_jdtls
})
