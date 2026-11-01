vim.pack.add({
  "https://github.com/mfussenegger/nvim-jdtls",
})

local utils = require("utils")
local jdtls = require("jdtls")

local data = vim.fn.stdpath("data")
local cache = vim.fn.stdpath("cache")
local config = vim.fn.stdpath("config")

-- ╭────────────────────────────────────────────────────────╮
-- │ ENVIONMENT / JDKs
-- ╰────────────────────────────────────────────────────────╯

local function require_env(name)
  local value = vim.env[name]

  if not value or value == "" then
    vim.notify(("Environment variable %s is not set, defaulting to mason"):format(name), vim.log.levels.WARN)
  end

  return value and value or ""
end

local function java_bin(java_home)
  local executable =
      vim.fn.has("win32") == 1 and "java.exe" or "java"

  local path = java_home .. "/bin/" .. executable

  if vim.fn.executable(path) ~= 1 then
    vim.notify("Java executable not found: " .. path, vim.log.levels.WARN)
  end

  return path
end

-- Load environment variables
local env_jdtls_java_home = require_env("JDTLS_JAVA_HOME")
local env_project_java_home = require_env("JAVA_HOME")
local env_jdtls_path = require_env("JDTLS_PATH")
local env_lombok_path = require_env("LOMBOK_PATH")
local env_debug_path = require_env("JAVA_DEBUG_PATH")

-- JDK used by the actual project/debugger.
local project_java = java_bin(env_project_java_home)
-- JDK used only to run JDTLS. (21+)
local jdtls_java = java_bin(env_jdtls_java_home)

-- ╭────────────────────────────────────────────────────────╮
-- │ MASON PATHS
-- ╰────────────────────────────────────────────────────────╯

local mason_path = data .. "/mason/packages"
local mason_jdtls_path = mason_path .. "jdtls"
local mason_lombok_path = mason_path .. "/lombok-nightly"
local mason_debug_path = mason_path .. "/java-debug-adapter"

-- ╭────────────────────────────────────────────────────────╮
-- │ RESOLVE DEPENDENCIES
-- ╰────────────────────────────────────────────────────────╯

local function resolve_dependency(name, envPath, masonPath, glob)
  -- Compute base directory
  local baseDir = envPath ~= "" and envPath or masonPath;
  if (baseDir == "") then
    vim.notify("Could not retrieve base path for dependency from path nor mason")
  end

  -- Find glob from base directory
  local jar = vim.fn.glob(baseDir .. glob)
  if not jar or jar == "" then
    vim.notify("Could not find " .. name .. " jar under: " .. baseDir, vim.log.levels.WARN)
  end

  return jar, baseDir
end

local launcher_jar, jdtls_path = resolve_dependency("JDTLS launcher",
  env_jdtls_path, mason_jdtls_path, "/**/org.eclipse.equinox.launcher_*.jar"
)
local lombok_jar, _ = resolve_dependency("LOMBOK",
  env_lombok_path, mason_lombok_path, "/**/lombok.jar"
)
local debug_jar, _ = resolve_dependency("DEBUG ADAPTER",
  env_debug_path, mason_debug_path,
  "/**/com.microsoft.java.debug.plugin-*.jar"
)

-- ╭────────────────────────────────────────────────────────╮
-- │ PLATFORM CONFIG
-- ╰────────────────────────────────────────────────────────╯

local config_dir = ({
  Linux = "config_linux",
  Darwin = "config_mac",
  Windows_NT = "config_win",
})[vim.uv.os_uname().sysname] or "config_linux"

local source_config = vim.fn.glob(jdtls_path .. "/**/" .. config_dir)
local config_path = vim.fs.joinpath(
  cache,
  "jdtls",
  vim.fn.sha256(jdtls_path):sub(1, 12),
  config_dir
)

-- Copy config directory from jdtls to cache
if vim.fn.isdirectory(config_path) == 0 then
  vim.fn.mkdir(vim.fn.fnamemodify(config_path, ":h"), "p")

  local result = vim.system({
    "cp", "-R", source_config, config_path,
  }):wait()

  assert(result.code == 0, result.stderr)

  vim.system({ "chmod", "-R", "u+w", config_path }):wait()
end

-- ╭────────────────────────────────────────────────────────╮
-- │ LSP CAPABILITIES AND DEBUG BUNDLES
-- ╰────────────────────────────────────────────────────────╯

local bundles = { debug_jar }

local capabilities =
    vim.lsp.protocol.make_client_capabilities()

capabilities.workspace =
    capabilities.workspace or {}

capabilities.workspace.fileOperations = {
  didCreate = true,
  willCreate = true,

  didRename = true,
  willRename = true,

  didDelete = true,
  willDelete = true,
}

-- PATCH JAVA DAP CONFIGS
-- JDTLS / java-debug may create Java launch configs dynamically.
-- Whenever configs exist, force the debuggee itself to use JAVA_HOME.

local function patch_java_dap_configs()
  local ok, dap = pcall(require, "dap")

  if not ok then
    return
  end

  if not dap.configurations.java then
    return
  end

  for _, dapconfig in ipairs(dap.configurations.java) do
    if dapconfig.request == "launch" then
      dapconfig.console =
      "integratedTerminal"

      dapconfig.shortenCommandLine =
      "argfile"

      -- JDTLS itself runs under JDTLS_JAVA_HOME.
      -- The debugged application runs under JAVA_HOME.
      dapconfig.javaExec =
          project_java
    end
  end
end


-- ╭────────────────────────────────────────────────────────╮
-- │ CUSTOM LANGUAGE FUNCTIONS
-- ╰────────────────────────────────────────────────────────╯

local function goto_test_or_source()
  local file =
      vim.api.nvim_buf_get_name(0)

  local source_root =
  "/src/main/java/"

  local test_root =
  "/src/test/java/"

  local target

  if file:find(test_root, 1, true) then
    target = file
        :gsub(test_root, source_root)
        :gsub("Test%.java$", ".java")
  elseif file:find(source_root, 1, true) then
    target = file
        :gsub(source_root, test_root)
        :gsub("%.java$", "Test.java")
  else
    vim.notify(
      "Not a Java source/test file",
      vim.log.levels.WARN
    )

    return
  end

  vim.fn.mkdir(
    vim.fn.fnamemodify(target, ":h"),
    "p"
  )

  vim.cmd.edit(
    vim.fn.fnameescape(target)
  )
end

-- ╭────────────────────────────────────────────────────────╮
-- │ ATTACH CALLBACK
-- ╰────────────────────────────────────────────────────────╯

local function on_jdtls_attach(client, _)
  require("lang").on_attach()

  -- ╭────────────────────────────────────────────────────────╮
  -- │ MAPPINGS
  -- ╰────────────────────────────────────────────────────────╯

  utils.enableMappings({
    {
      "<leader>t",
      goto_test_or_source,
      desc = "Go to test/source",
      buffer = true,
    },

    {
      "<leader>co",
      jdtls.organize_imports,
      desc = "Organize imports",
      buffer = true,
    },

    {
      "<leader>crv",
      jdtls.extract_variable,
      desc = "Extract variable",
      buffer = true,
    },

    {
      "<leader>crc",
      jdtls.extract_constant,
      desc = "Extract constant",
      buffer = true,
    },

    {
      "<leader>crm",
      jdtls.extract_method,
      desc = "Extract method",
      buffer = true,
    },
  })

  -- JAVA DAP
  -- Do NOT call setup_dap_main_class_configs() here.
  -- nvim-jdtls checks whether the Java debug extension is available and
  -- registers DAP support after the JDTLS client is attached.

  local commands =
      client.server_capabilities.executeCommandProvider
      and client.server_capabilities.executeCommandProvider.commands
      or {}

  if vim.tbl_contains(
        commands,
        "vscode.java.startDebugSession"
      ) then
    jdtls.setup_dap({
      hotcodereplace = "auto",
    })

    vim.schedule(function()
      patch_java_dap_configs()
    end)
  end
end

-- ╭────────────────────────────────────────────────────────╮
-- │ JAVA FILE CALLBACK
-- ╰────────────────────────────────────────────────────────╯

local function start_jdtls()

  -- Java Specific Vim configuration
  vim.bo.tabstop = 4
  vim.bo.shiftwidth = 4
  vim.bo.softtabstop = 4
  vim.bo.expandtab = false

  local root_dir =
      vim.fs.root(0, {
        ".git",

        "mvnw",
        "pom.xml",

        "gradlew",
        "build.gradle",
        "build.gradle.kts",
        "settings.gradle",
        "settings.gradle.kts",
      })

  if not root_dir then
    vim.notify(
      "Could not determine Java project root",
      vim.log.levels.WARN
    )

    return
  end

  -- ╭────────────────────────────────────────────────────────╮
  -- │ WORKSPACE
  -- ╰────────────────────────────────────────────────────────╯

  local project_name =
      vim.fn.fnamemodify(
        root_dir,
        ":t"
      )

  local root_hash =
      vim.fn.sha256(root_dir)
      :sub(1, 12)

  local workspace_dir =
      data
      .. "/jdtls-workspace/"
      .. project_name
      .. "-"
      .. root_hash


  -- ╭────────────────────────────────────────────────────────╮
  -- │ COMMAND
  -- ╰────────────────────────────────────────────────────────╯

  local cmd = {
    jdtls_java,

    "-Declipse.application=org.eclipse.jdt.ls.core.id1",
    "-Dosgi.bundles.defaultStartLevel=4",
    "-Declipse.product=org.eclipse.jdt.ls.core.product",

    "-Dlog.protocol=true",
    "-Dlog.level=ALL",

    "-Xms1g",

    "--add-opens",
    "java.base/java.util=ALL-UNNAMED",

    "--add-opens",
    "java.base/java.lang=ALL-UNNAMED",

    "-javaagent:" .. lombok_jar,

    "-jar",
    launcher_jar,

    "-configuration",
    config_path,

    "-data",
    workspace_dir,
  }

  -- ╭────────────────────────────────────────────────────────╮
  -- │ ATTACH
  -- ╰────────────────────────────────────────────────────────╯

  jdtls.start_or_attach(
    {
      cmd = cmd,

      root_dir = root_dir,

      capabilities = capabilities,

      on_attach = on_jdtls_attach,

      settings = {
        java = {
          configuration = {
            updateBuildConfiguration = "automatic",
          },

          -- ╭────────────────────────────────────────────────────────╮
          -- │ COMPLETION
          -- ╰────────────────────────────────────────────────────────╯

          completion = {
            favoriteStaticMembers = {
              "org.junit.jupiter.api.Assertions.*",
              "org.junit.jupiter.api.Assumptions.*",
              "org.junit.jupiter.params.provider.Arguments.*",

              "org.assertj.core.api.Assertions.*",

              "org.mockito.Mockito.*",
              "org.mockito.ArgumentMatchers.*",
              "org.mockito.BDDMockito.*",
              "org.mockito.Answers.*",

              "org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*",
              "org.springframework.test.web.servlet.result.MockMvcResultMatchers.*",
              "org.springframework.test.web.servlet.result.MockMvcResultHandlers.*",
              "org.springframework.security.test.web.servlet.request.SecurityMockMvcRequestPostProcessors.*",
              "org.springframework.test.web.client.match.MockRestRequestMatchers.*",
              "org.springframework.test.web.client.response.MockRestResponseCreators.*",
              "org.springframework.restdocs.request.RequestDocumentation.*",
              "org.springframework.restdocs.payload.PayloadDocumentation.*",
              "org.springframework.restdocs.operation.preprocess.Preprocessors.*",
              "org.springframework.restdocs.mockmvc.MockMvcRestDocumentation.*",
            },
          },

          -- ╭────────────────────────────────────────────────────────╮
          -- │ SOURCES
          -- ╰────────────────────────────────────────────────────────╯

          eclipse = {
            downloadSources = true,
          },

          maven = {
            downloadSources = true,
          },

          -- ╭────────────────────────────────────────────────────────╮
          -- │ CODELENS AND REFERENCES
          -- ╰────────────────────────────────────────────────────────╯

          implementationsCodeLens = {
            enabled = "none",
          },

          referencesCodeLens = {
            enabled = true,
          },

          references = {
            includeDecompiledSources = true,
          },

          -- ╭────────────────────────────────────────────────────────╮
          -- │ FORMATTING
          -- ╰────────────────────────────────────────────────────────╯

          format = {
            enabled = true,
            settings = {
              url = config .. "/assets/java-formatter.xml",
              profile = "MyStyle",
            },
          },
        },
      },

      flags = {
        allow_incremental_sync = true,
      },

      -- ╭────────────────────────────────────────────────────────╮
      -- │ INCLUDE DEBUG BUNDLES
      -- ╰────────────────────────────────────────────────────────╯

      init_options = {
        bundles = bundles,
      },
    },
    {
      dap = true,
    }
  )
end

-- ╭────────────────────────────────────────────────────────╮
-- │ AUTOCMD
-- ╰────────────────────────────────────────────────────────╯

vim.api.nvim_create_autocmd(
  "FileType",
  {
    pattern = "java",
    callback = start_jdtls,
  }
)
