local jdtls_ok, jdtls = pcall(require, "jdtls")
if not jdtls_ok then
  vim.notify("JDTLS not found, install with `:Mason`")
  return
end

-- Find root directory (usually the git root)
local root_markers = { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }
local root_dir = require("jdtls.setup").find_root(root_markers)
if not root_dir then
  return
end

-- Get jdtls installation path from Mason
local mason_registry = require("mason-registry")
local jdtls_path = mason_registry.get_package("jdtls"):get_install_path()

-- Set up data directory
local project_name = vim.fn.fnamemodify(root_dir, ":p:h:t")
local workspace_dir = vim.fn.expand("~/.cache/jdtls/workspace/") .. project_name

-- Command that starts the language server
local cmd = {
  "java",
  "-Declipse.application=org.eclipse.jdt.ls.core.id1",
  "-Dosgi.bundles.defaultStartLevel=4",
  "-Declipse.product=org.eclipse.jdt.ls.core.product",
  "-Dlog.protocol=true",
  "-Dlog.level=ALL",
  "-Xmx1g",
  "--add-modules=ALL-SYSTEM",
  "--add-opens", "java.base/java.util=ALL-UNNAMED",
  "--add-opens", "java.base/java.lang=ALL-UNNAMED",
  
  "-jar", vim.fn.glob(jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar"),
  
  "-configuration", jdtls_path .. "/config_linux", -- Adjust for your OS (linux/mac/win)
  
  "-data", workspace_dir,
}

-- LSP settings
local settings = {
  java = {
    signatureHelp = { enabled = true },
    contentProvider = { preferred = "fernflower" },
    completion = {
      favoriteStaticMembers = {
        "org.hamcrest.MatcherAssert.assertThat",
        "org.hamcrest.Matchers.*",
        "org.junit.Assert.*",
        "org.junit.Assume.*",
        "org.junit.jupiter.api.Assertions.*",
        "java.util.Objects.requireNonNull",
        "java.util.Objects.requireNonNullElse",
        "org.mockito.Mockito.*"
      },
      filteredTypes = {
        "com.sun.*",
        "io.micrometer.shaded.*",
        "java.awt.*",
        "jdk.*", 
        "sun.*",
      },
    },
    sources = {
      organizeImports = {
        starThreshold = 9999,
        staticStarThreshold = 9999,
      },
    },
    codeGeneration = {
      toString = {
        template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}"
      },
      hashCodeEquals = {
        useJava7Objects = true,
      },
      useBlocks = true,
    },
  }
}

-- Setup JDTLS
jdtls.start_or_attach({
  cmd = cmd,
  settings = settings,
  root_dir = root_dir,
  init_options = {
    bundles = {}
  }
})

-- Add Java-specific key mappings
vim.keymap.set("n", "<leader>ji", jdtls.organize_imports, { buffer = true, desc = "Organize Imports" })
vim.keymap.set("n", "<leader>jt", jdtls.test_class, { buffer = true, desc = "Test Class" })
vim.keymap.set("n", "<leader>jn", jdtls.test_nearest_method, { buffer = true, desc = "Test Nearest Method" })
vim.keymap.set("n", "<leader>jc", function() jdtls.extract_constant() end, { buffer = true, desc = "Extract Constant" })
vim.keymap.set("v", "<leader>jm", function() jdtls.extract_method() end, { buffer = true, desc = "Extract Method" })
