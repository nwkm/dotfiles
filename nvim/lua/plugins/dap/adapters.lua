local present_dapui, dapui = pcall(require, "dapui")
local present_dap, dap = pcall(require, "dap")
local present_virtual_text, dap_vt = pcall(require, "nvim-dap-virtual-text")
local map = vim.keymap.set
local opts = { noremap = true, silent = true }

if not present_dapui or not present_dap or not present_virtual_text then
  return
end

-- ╭──────────────────────────────────────────────────────────╮
-- │ DAP Virtual Text Setup                                   │
-- ╰──────────────────────────────────────────────────────────╯
dap_vt.setup({
  enabled = true,                       -- enable this plugin (the default)
  enabled_commands = true,              -- create commands DapVirtualTextEnable, DapVirtualTextDisable, DapVirtualTextToggle, (DapVirtualTextForceRefresh for refreshing when debug adapter did not notify its termination)
  highlight_changed_variables = true,   -- highlight changed values with NvimDapVirtualTextChanged, else always NvimDapVirtualText
  highlight_new_as_changed = false,     -- highlight new variables in the same way as changed variables (if highlight_changed_variables)
  show_stop_reason = true,              -- show stop reason when stopped for exceptions
  commented = false,                    -- prefix virtual text with comment string
  only_first_definition = true,         -- only show virtual text at first definition (if there are multiple)
  all_references = false,               -- show virtual text on all all references of the variable (not only definitions)
  filter_references_pattern = "<module", -- filter references (not definitions) pattern when all_references is activated (Lua gmatch pattern, default filters out Python modules)
  -- Experimental Features:
  virt_text_pos = "eol",                -- position of virtual text, see `:h nvim_buf_set_extmark()`
  all_frames = false,                   -- show virtual text for all stack frames not only current. Only works for debugpy on my machine.
  virt_lines = false,                   -- show virtual lines instead of virtual text (will flicker!)
  virt_text_win_col = nil,              -- position the virtual text at a fixed window column (starting from the first text column) ,
})

-- ╭──────────────────────────────────────────────────────────╮
-- │ DAP UI Setup                                             │
-- ╰──────────────────────────────────────────────────────────╯
dapui.setup({
  icons = { expanded = "▾", collapsed = "▸" },
  mappings = {
    -- Use a table to apply multiple mappings
    expand = { "<CR>", "<2-LeftMouse>" },
    open = "o",
    remove = "d",
    edit = "e",
    repl = "r",
    toggle = "t",
  },
  -- Expand lines larger than the window
  -- Requires >= 0.7
  expand_lines = vim.fn.has("nvim-0.7"),
  -- Layouts define sections of the screen to place windows.
  -- The position can be "left", "right", "top" or "bottom".
  -- The size specifies the height/width depending on position. It can be an Int
  -- or a Float. Integer specifies height/width directly (i.e. 20 lines/columns) while
  -- Float value specifies percentage (i.e. 0.3 - 30% of available lines/columns)
  -- Elements are the elements shown in the layout (in order).
  -- Layouts are opened in order so that earlier layouts take priority in window sizing.
  layouts = {
    {
      elements = {
        -- Elements can be strings or table with id and size keys.
        { id = "scopes", size = 0.25 },
        "breakpoints",
        "stacks",
        "watches",
      },
      size = 40, -- 40 columns
      position = "left",
    },
    {
      elements = {
        "repl",
        "console",
      },
      size = 0.25, -- 25% of total lines
      position = "bottom",
    },
  },
  floating = {
    max_height = nil,                           -- These can be integers or a float between 0 and 1.
    max_width = nil,                            -- Floats will be treated as percentage of your screen.
    border = nw.ui.float.border or "rounded", -- Border style. Can be "single", "double" or "rounded"
    mappings = {
      close = { "q", "<Esc>" },
    },
  },
  windows = { indent = 1 },
  render = {
    max_type_length = nil, -- Can be integer or nil.
  },
})

-- ╭──────────────────────────────────────────────────────────╮
-- │ DAP Setup                                                │
-- ╰──────────────────────────────────────────────────────────╯
dap.set_log_level("TRACE")

-- Automatically open UI
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.after.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end

-- Enable virtual text
vim.g.dap_virtual_text = true

-- ╭──────────────────────────────────────────────────────────╮
-- │ Icons                                                    │
-- ╰──────────────────────────────────────────────────────────╯
vim.fn.sign_define("DapBreakpoint", { text = "🟥", texthl = "", linehl = "", numhl = "" })
vim.fn.sign_define("DapStopped", { text = "", texthl = "DiagnosticSignWarn", linehl = "Visual", numhl = "DiagnosticSignWarn" })
vim.fn.sign_define('DapBreakpointRejected', { text="🟦", texthl="", linehl="", numhl="" })

-- ╭──────────────────────────────────────────────────────────╮
-- │ Keybindings                                              │
-- ╰──────────────────────────────────────────────────────────╯
map("n", "<Leader>db", "<CMD>lua require('dap').toggle_breakpoint()<CR>", opts)
map("n", "<Leader>dc", "<CMD>lua require('dap').continue()<CR>", opts)
map("n", "<Leader>dh", "<CMD>lua require('dapui').eval()<CR>", opts)
map("n", "<Leader>di", "<CMD>lua require('dap').step_into()<CR>", opts)
map("n", "<Leader>do", "<CMD>lua require('dap').step_out()<CR>", opts)
map("n", "<Leader>dO", "<CMD>lua require('dap').step_over()<CR>", opts)
map("n", "<Leader>dt", "<CMD>lua require('dap').terminate()<CR>", opts)
map("n", "<Leader>dC", "<CMD>lua require('dapui').close()<CR>", opts)

map("n", "<Leader>dw", "<CMD>lua require('dapui').float_element('watches', { enter = true })<CR>", opts)
map("n", "<Leader>ds", "<CMD>lua require('dapui').float_element('scopes', { enter = true })<CR>", opts)
map("n", "<Leader>dr", "<CMD>lua require('dapui').float_element('repl', { enter = true })<CR>", opts)

-- ╭──────────────────────────────────────────────────────────╮
-- │ Adapters                                                 │
-- ╰──────────────────────────────────────────────────────────╯
-- !DEPRECATED!
-- dap.adapters.node2 = {
--  type = "executable",
-- command = "node",
--args = { vim.fn.stdpath("data") .. "/mason/packages/node-debug2-adapter/out/src/nodeDebug.js" },
--}

-- !DEPRECATED!
-- dap.adapters.chrome = {
--   type = "executable",
--   command = "node",
--   args = { vim.fn.stdpath("data") .. "/mason/packages/chrome-debug-adapter/out/src/chromeDebug.js" },
-- }

-- Vscode JS
require("dap-vscode-js").setup({
  debugger_path = vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter",
  debugger_cmd = { "js-debug-adapter" },
  adapters = { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost" },
})

dap.adapters['pwa-node'] = {
  type = 'server',
  host = 'localhost',
  port = '${port}',
  -- port = '3000',
  executable = {
    command = 'js-debug-adapter',
    args = { '${port}' },
    -- args = { '3000' },
  }
}

-- "name": "Debugging",
-- "type": "node",
-- "request": "launch",
-- "cwd": "${workspaceRoot}",
-- "runtimeArgs": ["-r", "ts-node/register"],
-- "args": ["${workspaceRoot}/src/index.ts"]
-- "command": "npm run dev",
-- "name": "Run npm dev",
-- "request": "launch",
-- "type": "node-terminal"
-- ╭──────────────────────────────────────────────────────────╮
-- │ Configurations                                           │
-- ╰──────────────────────────────────────────────────────────╯
for _, language in ipairs { "typescript", "javascript" } do
  -- dap.configurations[language] = {
    -- {
    --   type = "pwa-node",
    --   request = "launch",
    --   name = "Launch file",
    --   program = "${file}",
    --   cwd = "${workspaceFolder}",
    -- },
    -- {
    --   type = "pwa-node",
    --   request = "launch",
    --   name = "Launch Current File (pwa-node)",
    --   cwd = vim.fn.getcwd(),
    --   args = { "${file}" },
    --   sourceMaps = true,
    --   protocol = "inspector",
    -- },
    -- {
    --   type = "pwa-node",
    --   request = "launch",
    --   name = "Debugging " .. "(" .. language .. ")",
    --   program = "${file}",
    --   cwd = "${workspaceFolder}",
    --   args = {
    --     '${workspaceRoot}/src/index.ts',
    --   },
    --   runtimeArgs = {
    --     "-r",
    --     "ts-node/register"
    --   },
    --   sourceMaps = true,
    -- },
    -- {
    --   type = "pwa-node",
    --   request = "launch",
    --   name = "Debug main process " .. "(" .. language .. ")",
    --   command = "npm run dev",
    -- },
    -- {
    --   type = "pwa-node",
    --   request = "launch",
    --   name = "Launch file " .. "(" .. language .. ")",
    --   program = "${file}",
    --   cwd = "${workspaceFolder}",
    --   protocol = "inspector",
	  --   console = "integratedTerminal",
	  --   runtimeExecutable = "${workspaceFolder}/node_modules/.bin/ts-node",
    --   resolveSourceMapLocations = { "${workspaceFolder}/dist/**/*.js", "${workspaceFolder}/**", "!**/node_modules/**" },
    --   skipFiles = { "<node_internals>/**", "**/node_modules/**" },
    --   port = 9229,
    --   sourceMaps = true
    -- },
  --   {
  --     type = "pwa-node",
  --     request = "attach",
  --     name = "Attach to process " .. "(" .. language .. ")",
  --     processId = require("dap.utils").pick_process,
  --     cwd = "${workspaceFolder}",
  --   },
  --   {
  --     type = "pwa-node",
  --     request = "launch",
  --     name = "Debug Jest Tests " .. "(" .. language .. ")",
  --     -- trace = true, -- include debugger info
  --     runtimeExecutable = "node",
  --     runtimeArgs = {
  --       "./node_modules/jest/bin/jest.js",
  --       "--runInBand",
  --       "${file}",
  --     },
  --     rootPath = "${workspaceFolder}",
  --     cwd = "${workspaceFolder}",
  --     console = "integratedTerminal",
  --     internalConsoleOptions = "neverOpen",
  --   },
  -- }
end
-- dap.configurations.typescript = {
--   {
--     name = "Node.js",
--     --type = "node2",
--     type = "pwa-node",
--     request = "launch",
--     program = "${file}",
--     cwd = vim.fn.getcwd(),
--     sourceMaps = true,
--     protocol = "inspector",
--     console = "integratedTerminal",
--   },
--   {
--     name = "Chrome (9222)",
--     type = "chrome",
--     request = "attach",
--     program = "${file}",
--     cwd = vim.fn.getcwd(),
--     sourceMaps = true,
--     protocol = "inspector",
--     port = 9222,
--     webRoot = "${workspaceFolder}",
--   },
-- }

-- dap.configurations.javascript = dap.configurations.typescript

-- dap.configurations.javascriptreact = {
--   {
--     name = "Chrome (9222)",
--     type = "chrome",
--     request = "attach",
--     program = "${file}",
--     cwd = vim.fn.getcwd(),
--     sourceMaps = true,
--     protocol = "inspector",
--     port = 9222,
--     webRoot = "${workspaceFolder}",
--   },
-- }

-- dap.configurations.typescriptreact = {
--   {
--     name = "Chrome (9222)",
--     type = "chrome",
--     request = "attach",
--     program = "${file}",
--     cwd = vim.fn.getcwd(),
--     sourceMaps = true,
--     protocol = "inspector",
--     port = 9222,
--     webRoot = "${workspaceFolder}",
--   },
--   {
--     name = "React Native (8081) (Node2)",
--     type = "node2",
--     request = "attach",
--     program = "${file}",
--     cwd = vim.fn.getcwd(),
--     sourceMaps = true,
--     protocol = "inspector",
--     console = "integratedTerminal",
--     port = 8081,
--   },
--   {
--     name = "Attach React Native (8081)",
--     type = "pwa-node",
--     request = "attach",
--     processId = require('dap.utils').pick_process,
--     cwd = vim.fn.getcwd(),
--     rootPath = '${workspaceFolder}',
--     skipFiles = { "<node_internals>/**", "node_modules/**" },
--     sourceMaps = true,
--     protocol = "inspector",
--     console = "integratedTerminal",
--   },
-- }

-- dap.configurations.java = {
--   {
--     name = "Debug (Attach) - Remote",
--     type = "java",
--     request = "attach",
--     hostName = "127.0.0.1",
--     port = 5005,
--   },
--   {
--     name = "Debug Non-Project class",
--     type = "java",
--     request = "launch",
--     program = "${file}",
--   },
-- }


-- local exts = {
--   'javascript',
--   'typescript',
--   'javascriptreact',
--   'typescriptreact',
--   -- using pwa-chrome
--   'vue',
--   'svelte',
-- }

-- for i, ext in ipairs(exts) do
--   dap.configurations[ext] = {
--     {
--       type = 'pwa-node',
--       request = 'launch',
--       name = 'Launch Current File (pwa-node)',
--       cwd = vim.fn.getcwd(),
--       args = { '${file}' },
--       sourceMaps = true,
--       protocol = 'inspector',
--     },
--     {
--       type = 'pwa-node',
--       request = 'launch',
--       name = 'Launch Current File (pwa-node with ts-node)',
--       cwd = vim.fn.getcwd(),
--       runtimeArgs = { '--loader', 'ts-node/esm' },
--       runtimeExecutable = 'node',
--       args = { '${file}' },
--       sourceMaps = true,
--       protocol = 'inspector',
--       skipFiles = { '<node_internals>/**', 'node_modules/**' },
--       resolveSourceMapLocations = {
--         "${workspaceFolder}/**",
--         "!**/node_modules/**",
--       },
--     },
--     {
--       type = 'pwa-node',
--       request = 'launch',
--       name = 'Launch Current File (pwa-node with deno)',
--       cwd = vim.fn.getcwd(),
--       runtimeArgs = { 'run', '--inspect-brk', '--allow-all', '${file}' },
--       runtimeExecutable = 'deno',
--       attachSimplePort = 9229,
--     },
--     {
--       type = 'pwa-node',
--       request = 'launch',
--       name = 'Launch Test Current File (pwa-node with jest)',
--       cwd = vim.fn.getcwd(),
--       runtimeArgs = { '${workspaceFolder}/node_modules/.bin/jest' },
--       runtimeExecutable = 'node',
--       args = { '${file}', '--coverage', 'false'},
--       rootPath = '${workspaceFolder}',
--       sourceMaps = true,
--       console = 'integratedTerminal',
--       internalConsoleOptions = 'neverOpen',
--       skipFiles = { '<node_internals>/**', 'node_modules/**' },
--     },
--     {
--       type = 'pwa-node',
--       request = 'launch',
--       name = 'Launch Test Current File (pwa-node with vitest)',
--       cwd = vim.fn.getcwd(),
--       program = '${workspaceFolder}/node_modules/vitest/vitest.mjs',
--       args = { '--inspect-brk', '--threads', 'false', 'run', '${file}' },
--       autoAttachChildProcesses = true,
--       smartStep = true,
--       console = 'integratedTerminal',
--       skipFiles = { '<node_internals>/**', 'node_modules/**' },
--     },
--     {
--       type = 'pwa-node',
--       request = 'launch',
--       name = 'Launch Test Current File (pwa-node with deno)',
--       cwd = vim.fn.getcwd(),
--       runtimeArgs = { 'test', '--inspect-brk', '--allow-all', '${file}' },
--       runtimeExecutable = 'deno',
--       attachSimplePort = 9229,
--     },
--     {
--       type = 'pwa-chrome',
--       request = 'attach',
--       name = 'Attach Program (pwa-chrome = { port: 9222 })',
--       program = '${file}',
--       cwd = vim.fn.getcwd(),
--       sourceMaps = true,
--       port = 9222,
--       webRoot = '${workspaceFolder}',
--     },
--     {
--       type = 'node2',
--       request = 'attach',
--       name = 'Attach Program (Node2)',
--       processId = require('dap.utils').pick_process,
--     },
--     {
--       type = 'node2',
--       request = 'attach',
--       name = 'Attach Program (Node2 with ts-node)',
--       cwd = vim.fn.getcwd(),
--       sourceMaps = true,
--       skipFiles = { '<node_internals>/**' },
--       port = 9229,
--     },
--     {
--       type = 'pwa-node',
--       request = 'attach',
--       name = 'Attach Program (pwa-node)',
--       cwd = vim.fn.getcwd(),
--       processId = require('dap.utils').pick_process,
--       skipFiles = { '<node_internals>/**' },
--     },
--   }
-- end