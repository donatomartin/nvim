
local lombok_path = vim.fn.expand("~") .. "/.local/share/nvim/mason/packages/lombok-nightly/lombok.jar"
vim.lsp.config["jdtls"] = {
  cmd = {
    "jdtls",
    "-Declipse.application=org.eclipse.jdt.ls.core.id1",
    "-Dosgi.bundles.defaultStartLevel=4",
    "-Declipse.product=org.eclipse.jdt.ls.core.product",
    "-Dlog.protocol=true",
    "-Dlog.level=ALL",
    "-Xms1g",
    "-Xmx2G",
    "--jvm-arg=-javaagent:" .. lombok_path,
  },
  filetypes = { "java" },
  root_markers = {
    "pom.xml",
    "settings.gradle",
    "mvnw",
    "gradlew",
    ".project",
  },
  -- settings = {
  -- 	java = {
  -- 		signatureHelp = {
  -- 			enabled = true,
  -- 		},
  -- 		configuration = {
  -- 			updateBuildConfiguration = "disabled",
  -- 		},
  -- 		project = {
  -- 			resourceFilters = {},
  -- 		},
  -- 	},
  -- },
}
