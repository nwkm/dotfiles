local ok_dap, dap = pcall(require, "dap")
local ok_dap_utils, dap_utils = pcall(require, "dap.utils")

if not (ok_dap and ok_dap_utils) then
	return
end

local exts = {
	"javascript",
	"typescript",
	"javascriptreact",
	"typescriptreact",
	"vue",
	"svelte",
}

local M = {}

function M.config_javascript()
	dap.configurations.javascript = {
		{
			type = "pwa-node",
			request = "launch",
			name = "Launch Current File (pwa-node)",
			cwd = vim.fn.getcwd(),
			args = { "${file}" },
			sourceMaps = true,
			protocol = "inspector",
		},
		{
			type = "pwa-node",
			request = "launch",
			name = "Launch Current File (pwa-node with deno)",
			cwd = vim.fn.getcwd(),
			runtimeArgs = { "run", "--inspect-brk", "--allow-all", "${file}" },
			runtimeExecutable = "deno",
			attachSimplePort = 9229,
		},
		{
			type = "pwa-node",
			request = "attach",
			name = "Attach Program (pwa-node, select pid)",
			cwd = vim.fn.getcwd(),
			processId = dap_utils.pick_process,
			skipFiles = { "<node_internals>/**" },
		},
		{
			type = "pwa-chrome",
			request = "attach",
			name = "Attach Program (pwa-chrome, select port)",
			program = "${file}",
			cwd = vim.fn.getcwd(),
			sourceMaps = true,
			port = function()
			  return vim.fn.input("Select port: ", 9222)
			end,
			webRoot = "${workspaceFolder}",
		},
		{
			type = "pwa-node",
			request = "launch",
			name = "Launch Test Current File (pwa-node with jest)",
			cwd = vim.fn.getcwd(),
			runtimeArgs = { "${workspaceFolder}/node_modules/.bin/jest" },
			runtimeExecutable = "node",
			args = { "${file}", "--coverage", "false" },
			rootPath = "${workspaceFolder}",
			sourceMaps = true,
			console = "integratedTerminal",
			internalConsoleOptions = "neverOpen",
			skipFiles = { "<node_internals>/**", "node_modules/**" },
		},
		{
			type = "pwa-node",
			request = "launch",
			name = "Launch Test Current File (pwa-node with vitest)",
			cwd = vim.fn.getcwd(),
			program = "${workspaceFolder}/node_modules/vitest/vitest.mjs",
			args = { "--inspect-brk", "--threads", "false", "run", "${file}" },
			autoAttachChildProcesses = true,
			smartStep = true,
			console = "integratedTerminal",
			skipFiles = { "<node_internals>/**", "node_modules/**" },
		},
		{
			type = "pwa-node",
			request = "launch",
			name = "Launch Test Current File (pwa-node with deno)",
			cwd = vim.fn.getcwd(),
			runtimeArgs = { "test", "--inspect-brk", "--allow-all", "${file}" },
			runtimeExecutable = "deno",
			smartStep = true,
			console = "integratedTerminal",
			attachSimplePort = 9229,
		},
	}
end

function M.config_typescript()
	dap.configurations.typescript = {
		{
			type = "pwa-node",
			request = "launch",
			name = "Launch Current File (pwa-node)",
			cwd = vim.fn.getcwd(),
			args = { "${file}" },
			sourceMaps = true,
			protocol = "inspector",
		},
		{
			type = "pwa-node",
			request = "launch",
			name = "Launch Current File (pwa-node with ts-node)",
			cwd = vim.fn.getcwd(),
			runtimeArgs = { "--loader", "ts-node/esm" },
			runtimeExecutable = "node",
			args = { "${file}" },
			sourceMaps = true,
			protocol = "inspector",
			skipFiles = { "<node_internals>/**", "node_modules/**" },
			resolveSourceMapLocations = {
			  "${workspaceFolder}/**",
			  "!**/node_modules/**",
			},
		},
		{
			type = "pwa-node",
			request = "launch",
			name = "Launch Current File (pwa-node with deno)",
			cwd = vim.fn.getcwd(),
			runtimeArgs = { "run", "--inspect-brk", "--allow-all", "${file}" },
			runtimeExecutable = "deno",
			attachSimplePort = 9229,
		},
		{
			type = "pwa-node",
			request = "attach",
			name = "Attach Program (pwa-node, select pid)",
			cwd = vim.fn.getcwd(),
			processId = dap_utils.pick_process,
			skipFiles = { "<node_internals>/**" },
		},
		{
			type = "pwa-chrome",
			request = "attach",
			name = "Attach Program (pwa-chrome, select port)",
			program = "${file}",
			cwd = vim.fn.getcwd(),
			sourceMaps = true,
			port = function()
			  return vim.fn.input("Select port: ", 9222)
			end,
			webRoot = "${workspaceFolder}",
		},
		{
			type = "pwa-node",
			request = "launch",
			name = "Launch Test Current File (pwa-node with jest)",
			cwd = vim.fn.getcwd(),
			runtimeArgs = { "${workspaceFolder}/node_modules/.bin/jest" },
			runtimeExecutable = "node",
			args = { "${file}", "--coverage", "false" },
			rootPath = "${workspaceFolder}",
			sourceMaps = true,
			console = "integratedTerminal",
			internalConsoleOptions = "neverOpen",
			skipFiles = { "<node_internals>/**", "node_modules/**" },
		},
		{
			type = "pwa-node",
			request = "launch",
			name = "Launch Test Current File (pwa-node with vitest)",
			cwd = vim.fn.getcwd(),
			program = "${workspaceFolder}/node_modules/vitest/vitest.mjs",
			args = { "--inspect-brk", "--threads", "false", "run", "${file}" },
			autoAttachChildProcesses = true,
			smartStep = true,
			console = "integratedTerminal",
			skipFiles = { "<node_internals>/**", "node_modules/**" },
		},
		{
			type = "pwa-node",
			request = "launch",
			name = "Launch Test Current File (pwa-node with deno)",
			cwd = vim.fn.getcwd(),
			runtimeArgs = { "test", "--inspect-brk", "--allow-all", "${file}" },
			runtimeExecutable = "deno",
			smartStep = true,
			console = "integratedTerminal",
			attachSimplePort = 9229,
		},
	}
end

function M.config_java()
	dap.configurations.java = {
		{
		  name = "Debug (Attach) - Remote",
		  type = "java",
		  request = "attach",
		  hostName = "127.0.0.1",
		  port = 5005,
		},
		{
		  name = "Debug Non-Project class",
		  type = "java",
		  request = "launch",
		  program = "${file}",
		},
	}
end

-- for _, ext in ipairs(exts) do
-- 	dap.configurations[ext] = {
-- 	  {
-- 		type = "pwa-node",
-- 		request = "launch",
-- 		name = "Launch Current File (pwa-node)",
-- 		cwd = vim.fn.getcwd(),
-- 		args = { "${file}" },
-- 		sourceMaps = true,
-- 		protocol = "inspector",
-- 	  },
-- 	  {
-- 		type = "pwa-node",
-- 		request = "launch",
-- 		name = "Launch Current File (pwa-node with ts-node)",
-- 		cwd = vim.fn.getcwd(),
-- 		runtimeArgs = { "--loader", "ts-node/esm" },
-- 		runtimeExecutable = "node",
-- 		args = { "${file}" },
-- 		sourceMaps = true,
-- 		protocol = "inspector",
-- 		skipFiles = { "<node_internals>/**", "node_modules/**" },
-- 		resolveSourceMapLocations = {
-- 		  "${workspaceFolder}/**",
-- 		  "!**/node_modules/**",
-- 		},
-- 	  },
-- 	  {
-- 		type = "pwa-node",
-- 		request = "launch",
-- 		name = "Launch Current File (pwa-node with deno)",
-- 		cwd = vim.fn.getcwd(),
-- 		runtimeArgs = { "run", "--inspect-brk", "--allow-all", "${file}" },
-- 		runtimeExecutable = "deno",
-- 		attachSimplePort = 9229,
-- 	  },
-- 	  {
-- 		type = "pwa-node",
-- 		request = "launch",
-- 		name = "Launch Test Current File (pwa-node with jest)",
-- 		cwd = vim.fn.getcwd(),
-- 		runtimeArgs = { "${workspaceFolder}/node_modules/.bin/jest" },
-- 		runtimeExecutable = "node",
-- 		args = { "${file}", "--coverage", "false" },
-- 		rootPath = "${workspaceFolder}",
-- 		sourceMaps = true,
-- 		console = "integratedTerminal",
-- 		internalConsoleOptions = "neverOpen",
-- 		skipFiles = { "<node_internals>/**", "node_modules/**" },
-- 	  },
-- 	  {
-- 		type = "pwa-node",
-- 		request = "launch",
-- 		name = "Launch Test Current File (pwa-node with vitest)",
-- 		cwd = vim.fn.getcwd(),
-- 		program = "${workspaceFolder}/node_modules/vitest/vitest.mjs",
-- 		args = { "--inspect-brk", "--threads", "false", "run", "${file}" },
-- 		autoAttachChildProcesses = true,
-- 		smartStep = true,
-- 		console = "integratedTerminal",
-- 		skipFiles = { "<node_internals>/**", "node_modules/**" },
-- 	  },
-- 	  {
-- 		type = "pwa-node",
-- 		request = "launch",
-- 		name = "Launch Test Current File (pwa-node with deno)",
-- 		cwd = vim.fn.getcwd(),
-- 		runtimeArgs = { "test", "--inspect-brk", "--allow-all", "${file}" },
-- 		runtimeExecutable = "deno",
-- 		smartStep = true,
-- 		console = "integratedTerminal",
-- 		attachSimplePort = 9229,
-- 	  },
-- 	  {
-- 		type = "pwa-chrome",
-- 		request = "attach",
-- 		name = "Attach Program (pwa-chrome, select port)",
-- 		program = "${file}",
-- 		cwd = vim.fn.getcwd(),
-- 		sourceMaps = true,
-- 		port = function()
-- 		  return vim.fn.input("Select port: ", 9222)
-- 		end,
-- 		webRoot = "${workspaceFolder}",
-- 	  },
-- 	  -- {
-- 	  --   type = "node2",
-- 	  --   request = "attach",
-- 	  --   name = "Attach Program (Node2)",
-- 	  --   processId = dap_utils.pick_process,
-- 	  -- },
-- 	  -- {
-- 	  --   type = "node2",
-- 	  --   request = "attach",
-- 	  --   name = "Attach Program (Node2 with ts-node)",
-- 	  --   cwd = vim.fn.getcwd(),
-- 	  --   sourceMaps = true,
-- 	  --   skipFiles = { "<node_internals>/**" },
-- 	  --   port = 9229,
-- 	  -- },
-- 	  {
-- 		type = "pwa-node",
-- 		request = "attach",
-- 		name = "Attach Program (pwa-node, select pid)",
-- 		cwd = vim.fn.getcwd(),
-- 		processId = dap_utils.pick_process,
-- 		skipFiles = { "<node_internals>/**" },
-- 	  },
-- 	}
-- end

return M