-- mfussenegger/nvim-dap
local dap = require('dap')
dap.adapters.node2 = {
  type = 'executable',
  command = 'node',
  args = {os.getenv('HOME') .. '/apps/node/out/src/nodeDebug.js'},
}

-- require('dap').set_log_level('INFO')
dap.defaults.fallback.terminal_win_cmd = '20split new'
vim.fn.sign_define('DapBreakpoint', {text='🟥', texthl='', linehl='', numhl=''})
vim.fn.sign_define('DapBreakpointRejected', {text='🟦', texthl='', linehl='', numhl=''})
vim.fn.sign_define('DapStopped', {text='⭐️', texthl='', linehl='', numhl=''})

local nmap = require('config.utils').nmap

nmap('<leader>dh', function() require"dap".toggle_breakpoint() end)
nmap('<leader>dH', ":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>")
nmap('<A-k>', function() require"dap".step_out() end)
nmap('<A-l>', function() require"dap".step_into() end)
nmap('<A-j>', function() require"dap".step_over() end)
nmap('<A-h>', function() require"dap".continue() end)
nmap('<leader>dn', function() require"dap".run_to_cursor() end)
nmap('<leader>dc', function() require"dap".terminate() end)
nmap('<leader>dR', function() require"dap".clear_breakpoints() end)
nmap('<leader>de', function() require"dap".set_exception_breakpoints({"all"}) end)
nmap('<leader>da', function() require"debugHelper".attach() end)
nmap('<leader>dA', function() require"debugHelper".attachToRemote() end)
nmap('<leader>di', function() require"dap.ui.widgets".hover() end)
nmap('<leader>d?', function() local widgets=require"dap.ui.widgets";widgets.centered_float(widgets.scopes) end)
nmap('<leader>dk', ':lua require"dap".up()<CR>zz')
nmap('<leader>dj', ':lua require"dap".down()<CR>zz')
nmap('<leader>dr', ':lua require"dap".repl.toggle({}, "vsplit")<CR><C-w>l')