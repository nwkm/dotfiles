local status_ok, jdtls = pcall(require, "jdtls")
if not status_ok then
  return
end
-- local home = os.getenv('HOME')
local home = vim.env.HOME
-- local launcher_path = vim.fn.glob(home .. "/.local/share/nvim/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_*.jar")
-- if #launcher_path == 0 then
--   launcher_path = vim.fn.glob(home .. "/.local/share/nvim/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_*.jar", 1, 1)[1]
-- end
local mason_path = vim.fn.glob(vim.fn.stdpath "data" .. "/mason")
local launcher_path = vim.fn.glob(mason_path .. "/packages/jdtls/plugins/org.eclipse.equinox.launcher_*.jar")
if #launcher_path == 0 then
  launcher_path = vim.fn.glob(mason_path .. "/packages/jdtls/plugins/org.eclipse.equinox.launcher_*.jar", true, true)[1]
end
if vim.fn.has "mac" == 1 then
  WORKSPACE_PATH = home .. "/git/workspace/"
  CONFIG = "mac"
elseif vim.fn.has "unix" == 1 then
  WORKSPACE_PATH = home .. "/git/workspace/"
  CONFIG = "linux"
else
  print "Unsupported system"
end
-- Find root of project
local root_markers = { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }
local root_dir = require("jdtls.setup").find_root(root_markers)
if root_dir == "" then
  return
end

local extendedClientCapabilities = jdtls.extendedClientCapabilities
extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")

local workspace_dir = WORKSPACE_PATH .. project_name

local remap = function(mode, rhs, lhs, bufopts, desc)
	if bufopts == nil then
	  bufopts = {}
	end
	bufopts.desc = desc
	vim.keymap.set(mode, rhs, lhs, bufopts)
end

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)

  jdtls.setup_dap({ hotcodereplace = 'auto' })
  -- jdtls.dap.setup_dap_main_class_configs()
  jdtls.setup.add_commands()

  -- Default keymaps
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  -- require("lsp.defaults").on_attach(client, bufnr)

  -- Java extensions
  remap("n", "<C-o>", jdtls.organize_imports, bufopts, "Organize imports")
  -- remap("n", "<leader>vc", jdtls.test_class, bufopts, "Test class (DAP)")
  -- remap("n", "<leader>vm", jdtls.test_nearest_method, bufopts, "Test method (DAP)")
  -- remap("n", "<space>ev", jdtls.extract_variable, bufopts, "Extract variable")
  -- remap("n", "<space>ec", jdtls.extract_constant, bufopts, "Extract constant")
  -- remap("v", "<space>em", [[<ESC><CMD>lua require('jdtls').extract_method(true)<CR>]], bufopts, "Extract method")
end

-- local bundles = {
--   vim.fn.glob(home .. '/code/java-debug/com.microsoft.java.debug.plugin-*.jar'),
-- }
-- vim.list_extend(bundles, vim.split(vim.fn.glob(home .. '/code/java-test/*.jar'), "\n"))


-- local bundles = vim.fn.glob(home .. "/.local/share/nvim/mason/packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar", true, true)

-- local extra_bundles = vim.split(vim.fn.glob(home .. "/.local/share/nvim/mason/packages/java-test/extension/server/*.jar"), "\n")

-- vim.list_extend(bundles, extra_bundles)

-- Test bundle
-- Run :MasonInstall java-test
local bundles = { vim.fn.glob(mason_path .. "/packages/java-test/extension/server/*.jar", true) }
if #bundles == 0 then
  bundles = { vim.fn.glob(mason_path .. "/packages/java-test/extension/server/*.jar", true) }
end
-- Debug bundle
-- Run :MasonInstall java-debug-adapter
local extra_bundles = vim.fn.glob(mason_path .. "/packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar", true)
if #extra_bundles == 0 then
  extra_bundles = vim.fn.glob(
    mason_path .. "/packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar",
    true
  )
end
vim.list_extend(bundles, { extra_bundles })


local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

local config = {
  flags = {
    debounce_text_changes = 80,
  },
  capabilities = capabilities,
  on_attach = on_attach,
  init_options = {
    extendedClientCapabilities = extendedClientCapabilities,
    bundles = bundles
  },
  handlers = {
    -- ['language/status'] = function(_, result)
      -- Print or whatever.
    -- end,
    ['$/progress'] = function(_, result, ctx)
        -- disable progress updates.
    end,
  },
  root_dir = root_dir,
  settings = {
    java = {
      format = {
        settings = {
          url = "/.local/share/eclipse/eclipse-java-google-style.xml",
          profile = "GoogleStyle",
        },
      },
      import = {
        bazel = {
          enabled = true,
          src = {
            path = "/src/main/java"
          }
        },
        gradle = {
          enabled = true
        },
        maven = {
          enabled = true
        },
      },
      project = {
        sourcePaths = {
          "src",
        },
        outPath = "bazel-out",
      },
      saveActions = {
        organizeImports = true,
      },
      signatureHelp = { enabled = true },
      contentProvider = { preferred = 'fernflower' }, -- Use fernflower to decompile library code
      completion = {
        maxResults = 30,
        postfix = { enabled = true },
        favoriteStaticMembers = {
          "org.assertj.core.api.Assertions.*",
          "org.junit.Assert.*",
          "org.junit.Assume.*",
          "org.junit.jupiter.api.Assertions.*",
          "org.junit.jupiter.api.Assumptions.*",
          "org.junit.jupiter.api.DynamicContainer.*",
          "org.junit.jupiter.api.DynamicTest.*",
          "org.mockito.Mockito.*",
          "org.mockito.ArgumentMatchers.*",
          "org.mockito.Answers.*",
          "org.hamcrest.MatcherAssert.assertThat",
          "org.hamcrest.Matchers.*",
          "org.hamcrest.CoreMatchers.*",
        },
        filteredTypes = {
          "com.sun.*",
          "io.micrometer.shaded.*",
          "java.awt.*",
          "jdk.*",
          "sun.*",
        },
        importOrder = {
          "#",
          "java",
          "javax",
          "oracle",
          "org",
          "com",
        },
      },
      sources = {
        organizeImports = {
          starThreshold = 9999;
          staticStarThreshold = 9999;
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
      configuration = {
        runtimes = {
          {
            name = "JavaSE-21",
            path = home .. "/.sdkman/candidates/java/21.0.2-graalce",
          },
          {
            name = "JavaSE-17",
            path = home .. "/.jenv/versions/17.0.7",
          },
          -- {
          --   name = "JavaSE-11",
          --   path = home .. "/.jenv/versions/11.0.5",
          -- },
          -- {
          --   name = "JavaSE-1.8",
          --   path = home .. "/.jenv/versions/1.8.0.232"
          -- },
        }
      }
    }
  },
  cmd = {
    "java",
    "-Declipse.application=org.eclipse.jdt.ls.core.id1",
    "-Dosgi.bundles.defaultStartLevel=4",
    "-Declipse.product=org.eclipse.jdt.ls.core.product",
    "-Dlog.protocol=true",
    "-Dlog.level=ALL",
    "-Xmx4g",
    "--add-modules=ALL-SYSTEM",
    "--add-opens", "java.base/java.util=ALL-UNNAMED",
    "--add-opens", "java.base/java.lang=ALL-UNNAMED",
    "-javaagent:" .. mason_path .. "/packages/jdtls/lombok.jar",
    "-jar",
    launcher_path,
    "-configuration",
    home .. "/.local/share/nvim/mason/packages/jdtls/config_" .. CONFIG,
    "-data",
    workspace_dir,
  },
}

local M = {}

function M.make_jdtls_config()
  return config
end

return M
