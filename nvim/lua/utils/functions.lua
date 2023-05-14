local utils = require('utils')

local async_present, async = pcall(require, "plenary.async")
if not async_present then
  return
end

-- Exported functions
local M = {}

M.first_nvim_run = function()
  local is_first_run = utils.file_exists('/tmp/first-nvim-run')

  if is_first_run then
    async.run(function()
      require('notify')("Welcome to Neovim! Hope you'll have a nice experience!", "info", { title = "Neovim", timeout = 5000 })
      require('notify')("Please install treesitter servers manually by :TSInstall command.", "info", { title = "Installation", timeout = 10000 })
    end)
    local suc = os.remove('/tmp/first-nvim-run')
    if (not suc) then print("Error: Couldn't remove /tmp/first-nvim-run!") end
  end
end

M.first_nvim_run()

local present, win = pcall(require, "lspconfig.ui.windows")
if not present then
  return
end

local _default_opts = win.default_opts
win.default_opts = function(options)
  local opts = _default_opts(options)
  opts.border = nw.ui.float.border
  return opts
end

return M
