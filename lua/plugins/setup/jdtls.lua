vim.pack.add({
  "https://github.com/mfussenegger/nvim-jdtls",
})

local utils = require("utils")
local jdtls = require("jdtls")

local data = vim.fn.stdpath("data")

--------------------------------------------------------------------------------
-- ENVIRONMENT / JDKS
--------------------------------------------------------------------------------

local function require_env(name)
  local value = vim.env[name]

  if not value or value == "" then
    error(("Environment variable %s is not set"):format(name))
  end

  return value
end

local function java_bin(java_home)
  local executable =
      vim.fn.has("win32") == 1 and "java.exe" or "java"

  local path = java_home .. "/bin/" .. executable

  if vim.fn.executable(path) ~= 1 then
    error("Java executable not found: " .. path)
  end

  return path
end

-- JDK used only to run JDTLS.
-- JDTLS currently requires Java 21+.
local jdtls_java_home = require_env("JDTLS_JAVA_HOME")

-- JDK used by the actual project/debuggee.
local project_java_home = require_env("JAVA_HOME")

local jdtls_java = java_bin(jdtls_java_home)
local project_java = java_bin(project_java_home)

--------------------------------------------------------------------------------
-- MASON PATHS
--------------------------------------------------------------------------------

local mason_path = data .. "/mason/packages"

local jdtls_path =
    mason_path .. "/jdtls"

local lombok_path =
    mason_path .. "/lombok-nightly/lombok.jar"

local launcher_jar =
    vim.fn.glob(
      jdtls_path
      .. "/plugins/org.eclipse.equinox.launcher_*.jar"
    )

if launcher_jar == "" then
  error(
    "Could not find JDTLS launcher jar under: "
    .. jdtls_path
  )
end

--------------------------------------------------------------------------------
-- PLATFORM-SPECIFIC JDTLS CONFIG
--------------------------------------------------------------------------------

local config_dir

if vim.fn.has("mac") == 1 then
  config_dir = "config_mac"
elseif vim.fn.has("win32") == 1 then
  config_dir = "config_win"
else
  config_dir = "config_linux"
end

local config_path =
    jdtls_path .. "/" .. config_dir

--------------------------------------------------------------------------------
-- JAVA DEBUG BUNDLE
--------------------------------------------------------------------------------

local bundles = {}

local java_debug_bundle =
    vim.fn.glob(
      mason_path
      .. "/java-debug-adapter/"
      .. "extension/server/"
      .. "com.microsoft.java.debug.plugin-*.jar"
    )

if java_debug_bundle ~= "" then
  table.insert(
    bundles,
    java_debug_bundle
  )
else
  vim.notify(
    "java-debug-adapter bundle not found",
    vim.log.levels.WARN
  )
end

--------------------------------------------------------------------------------
-- LSP CAPABILITIES
--------------------------------------------------------------------------------

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

--------------------------------------------------------------------------------
-- SOURCE / TEST TOGGLE
--------------------------------------------------------------------------------

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

--------------------------------------------------------------------------------
-- PATCH JAVA DAP CONFIGS
--
-- JDTLS / java-debug may create Java launch configs dynamically.
-- Whenever configs exist, force the debuggee itself to use JAVA_HOME.
--------------------------------------------------------------------------------

local function patch_java_dap_configs()
  local ok, dap = pcall(require, "dap")

  if not ok then
    return
  end

  if not dap.configurations.java then
    return
  end

  for _, config in ipairs(dap.configurations.java) do
    if config.request == "launch" then
      config.console =
      "integratedTerminal"

      config.shortenCommandLine =
      "argfile"

      -- JDTLS itself runs under JDTLS_JAVA_HOME.
      -- The debugged application runs under JAVA_HOME.
      config.javaExec =
          project_java
    end
  end
end

--------------------------------------------------------------------------------
-- JDTLS ATTACH CALLBACK
--------------------------------------------------------------------------------

local function on_jdtls_attach(client, bufnr)
  ---------------------------------------------------------------------------
  -- GENERIC LSP ATTACH
  ---------------------------------------------------------------------------

  require("lang").on_attach()

  ---------------------------------------------------------------------------
  -- JAVA KEYMAPS
  ---------------------------------------------------------------------------

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

  ---------------------------------------------------------------------------
  -- JAVA DAP
  --
  -- Do NOT call setup_dap_main_class_configs() here.
  --
  -- nvim-jdtls checks whether the Java debug extension is available and
  -- registers DAP support after the JDTLS client is attached.
  ---------------------------------------------------------------------------

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

--------------------------------------------------------------------------------
-- START JDTLS
--------------------------------------------------------------------------------

local function start_jdtls()
  ---------------------------------------------------------------------------
  -- PROJECT ROOT
  ---------------------------------------------------------------------------

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

  ---------------------------------------------------------------------------
  -- WORKSPACE
  ---------------------------------------------------------------------------

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

  ---------------------------------------------------------------------------
  -- JDTLS COMMAND
  --
  -- Explicitly use JDTLS_JAVA_HOME here.
  --
  -- JAVA_HOME remains untouched and continues to control Maven/Gradle/etc.
  ---------------------------------------------------------------------------

  local cmd = {
    jdtls_java,

    "-Declipse.application=org.eclipse.jdt.ls.core.id1",
    "-Dosgi.bundles.defaultStartLevel=4",
    "-Declipse.product=org.eclipse.jdt.ls.core.product",

    "-Dlog.protocol=true",
    "-Dlog.level=ALL",

    "-Xms1g",

    "--add-modules=ALL-SYSTEM",

    "--add-opens",
    "java.base/java.util=ALL-UNNAMED",

    "--add-opens",
    "java.base/java.lang=ALL-UNNAMED",
  }

  ---------------------------------------------------------------------------
  -- LOMBOK FOR JDTLS
  ---------------------------------------------------------------------------

  if vim.fn.filereadable(lombok_path) == 1 then
    table.insert(
      cmd,
      "-javaagent:" .. lombok_path
    )
  else
    vim.notify(
      "Lombok jar not found: " .. lombok_path,
      vim.log.levels.WARN
    )
  end

  ---------------------------------------------------------------------------
  -- JDTLS LAUNCHER
  ---------------------------------------------------------------------------

  vim.list_extend(cmd, {
    "-jar",
    launcher_jar,

    "-configuration",
    config_path,

    "-data",
    workspace_dir,
  })

  ---------------------------------------------------------------------------
  -- START / ATTACH
  ---------------------------------------------------------------------------

  jdtls.start_or_attach(
    {
      cmd = cmd,

      root_dir = root_dir,

      capabilities = capabilities,

      on_attach = on_jdtls_attach,

      settings = {
        java = {
          ---------------------------------------------------------------------
          -- PROJECT JDK
          --
          -- Deliberately no JavaSE-17 hard-coding here.
          --
          -- Project version is determined through JAVA_HOME and the project's
          -- own Maven/Gradle/toolchain configuration.
          ---------------------------------------------------------------------

          configuration = {
            updateBuildConfiguration =
            "automatic",
          },

          ---------------------------------------------------------------------
          -- COMPLETION
          ---------------------------------------------------------------------

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

          ---------------------------------------------------------------------
          -- SOURCES
          ---------------------------------------------------------------------

          eclipse = {
            downloadSources = true,
          },

          maven = {
            downloadSources = true,
          },

          ---------------------------------------------------------------------
          -- CODE LENS
          ---------------------------------------------------------------------

          implementationsCodeLens = {
            enabled = true,
          },

          referencesCodeLens = {
            enabled = true,
          },

          ---------------------------------------------------------------------
          -- REFERENCES
          ---------------------------------------------------------------------

          references = {
            includeDecompiledSources = true,
          },

          ---------------------------------------------------------------------
          -- FORMATTING
          ---------------------------------------------------------------------

          format = {
            enabled = true,
          },
        },
      },

      flags = {
        allow_incremental_sync = true,
      },

      -------------------------------------------------------------------------
      -- JAVA DEBUG EXTENSION
      -------------------------------------------------------------------------

      init_options = {
        bundles = bundles,
      },
    },

    ---------------------------------------------------------------------------
    -- Important:
    --
    -- Passing dap=true tells nvim-jdtls to add its DAP commands during
    -- attachment, but only once the JDTLS server advertises java-debug.
    --
    -- This avoids the race you were seeing with resolveMainClass.
    ---------------------------------------------------------------------------

    {
      dap = true,
    }
  )
end

--------------------------------------------------------------------------------
-- AUTOCMD
--------------------------------------------------------------------------------

vim.api.nvim_create_autocmd(
  "FileType",
  {
    pattern = "java",
    callback = start_jdtls,
  }
)

--------------------------------------------------------------------------------
-- OPTIONAL: PATCH DAP CONFIGS AGAIN WHEN DAP IS OPENED
--
-- Main-class configurations can be generated lazily, so patching here makes
-- sure newly created launch configs also use $JAVA_HOME.
--------------------------------------------------------------------------------

local ok_dap, dap = pcall(require, "dap")

if ok_dap then
  dap.listeners.before.launch["java_runtime"] = function()
    patch_java_dap_configs()
  end
end
