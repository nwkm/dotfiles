local M = {}
local DEFAULT_OPTS = { noremap = true }

-- expand or minimize current buffer in a more natural direction (tmux-like)
-- ':resize <+-n>' or ':vert resize <+-n>' increases or decreasese current
-- window horizontally or vertically. When mapped to '<leader><arrow>' this
-- can get confusing as left might actually be right, etc
-- the below can be mapped to arrows and will work similar to the tmux binds
-- map to: "<cmd>lua require'utils'.resize(false, -5)<CR>"
function M.resize(vertical, margin)
	local cur_win = vim.api.nvim_get_current_win()
	-- go (possibly) right
	vim.cmd(string.format('wincmd %s', vertical and 'l' or 'j'))
	local new_win = vim.api.nvim_get_current_win()
  
	-- determine direction cond on increase and existing right-hand buffer
	local not_last = not (cur_win == new_win)
	local sign = margin > 0
	-- go to previous window if required otherwise flip sign
	if not_last == true then
	  vim.cmd [[wincmd p]]
	else
	  sign = not sign
	end
  
	sign = sign and '+' or '-'
	local dir = vertical and 'vertical ' or ''
	local cmd = dir .. 'resize ' .. sign .. math.abs(margin) .. '<CR>'
	vim.cmd(cmd)
end


-- M.map = function(mode, lhs, rhs, opts)
-- 	local options = { noremap = true, silent = true }
-- 	if opts then
-- 	  options = M.merge(options, opts)
-- 	end
-- 	vim.api.nvim_set_keymap(mode, lhs, rhs, options)
-- end

-- function M.buf_map(bufnr, mode, lhs, rhs, opts)
-- 	local options = { noremap = true, silent = true }
-- 	if opts then
-- 	  options = M.merge(options, opts)
-- 	end
-- 	vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, options)
-- end

-- function M.merge(...)
-- 	return vim.tbl_deep_extend('force', ...)
-- end

-- function M.split(str, sep)
-- 	local res = {}
-- 	for w in str:gmatch('([^' .. sep .. ']*)') do
-- 	  if w ~= '' then
-- 		table.insert(res, w)
-- 	  end
-- 	end
-- 	return res
-- end

-- M.get_active_lsp_client_names = function()
-- 	local active_clients = vim.lsp.get_active_clients()
-- 	local client_names = {}
-- 	for _, client in pairs(active_clients or {}) do
-- 	  local buf = vim.api.nvim_get_current_buf()
-- 	  -- only return attached buffers
-- 	  if vim.lsp.buf_is_attached(buf, client.id) then
-- 		table.insert(client_names, client.name)
-- 	  end
-- 	end
  
-- 	if not vim.tbl_isempty(client_names) then
-- 	  table.sort(client_names)
-- 	end
-- 	return client_names
-- end

function M.set_highlight(hi, colors)
	local hi_str = ''
  
	for k, v in pairs(colors) do
	  hi_str = hi_str .. k .. '=' .. v .. ' '
	end
  
	vim.cmd(('hi %s %s'):format(hi, hi_str))
end
  
-- M.get_highlight = function(hi)
-- 	local hi_str = vim.api.nvim_command_output(('hi %s'):format(hi))
  
-- 	local colors = {}
-- 	for key, val in string.gmatch(hi_str, '(%w+)=(%S+)') do
-- 	  colors[key] = val
-- 	end
  
-- 	return colors
-- end

---Validate user opts
---@param input string
---@param exec string|function
---@return nil
local function validate(input, exec)
  vim.validate({
    input = { input, 'string' },
    exec = { exec, { 'string', 'function' } },
  })
end

---Merge default opts from user provided opts
---@param opts table
---@return table
local function merge_opts(opts)
  if opts and type(opts) == 'table' then
    opts = vim.tbl_extend('force', DEFAULT_OPTS, opts)
  else
    opts = DEFAULT_OPTS
  end

  return opts
end

---Map input to exec with provided mode and opts
---@param mode string
---@param input string
---@param exec string|function
---@param opts table|nil
---@return nil
local function mapper(mode, input, exec, opts)
  local ok, errmsg = pcall(validate, input, exec)

  if not ok then
    -- err(errmsg)
    return
  end

  opts = merge_opts(opts)

  if opts.bufnr then
    local bufnr = opts.bufnr
    opts.bufnr = nil

    ok, errmsg = pcall(vim.keymap.set, mode, input, exec, vim.tbl_extend('force', { buffer = bufnr }, opts))

    if not ok then
    --   err(errmsg)
		  return
    end
  else
    ok, errmsg = pcall(vim.keymap.set, mode, input, exec, opts)

    if not ok then
    --   err(errmsg)
		  return
    end
  end
end

---Create a normal, visual and operator-pending mode keymap, see :help mapmode-nvo
---@param input string
---@param exec string|function
---@param opts table
function M.map(input, exec, opts)
  mapper('', input, exec, opts)
end

---Create a normal mode keymap, see :help mapmode-n
---@param input string
---@param exec string|function
---@param opts table
function M.nmap(input, exec, opts)
  mapper('n', input, exec, opts)
end

---Create an insert mode keymap, see :help mapmode-i
---@param input string
---@param exec string|function
---@param opts table
function M.imap(input, exec, opts)
  mapper('i', input, exec, opts)
end

---Create a visual mode keymap, see :help mapmode-v
---@param input string
---@param exec string|function
---@param opts table
function M.vmap(input, exec, opts)
  mapper('v', input, exec, opts)
end

---Create a terminal mode keymap, see :help mapmode-t
---@param input string
---@param exec string|function
---@param opts table
function M.tmap(input, exec, opts)
  mapper('t', input, exec, opts)
end

---Create a command line mode keymap, see :help mapmode-c
---@param input string
---@param exec string|function
---@param opts table
function M.cmap(input, exec, opts)
  mapper('c', input, exec, opts)
end

---Create a visual and select mode keymap, see :help mapmode-x
---@param input string
---@param exec string|function
---@param opts table
function M.xmap(input, exec, opts)
  mapper('x', input, exec, opts)
end

---Create an operator-pending mode keymap, see :help mapmode-o
---@param input string
---@param exec string|function
---@param opts table
function M.omap(input, exec, opts)
  mapper('o', input, exec, opts)
end

---Create a select mode keymap, see :help mapmode-s
---@param input string
---@param exec string|function
---@param opts table
function M.smap(input, exec, opts)
  mapper('s', input, exec, opts)
end

function M.command(name, fn, opts)
  vim.api.nvim_create_user_command(name, fn, opts or {})
end

function M.buf_command(bufnr, name, fn, opts)
  vim.api.nvim_buf_create_user_command(bufnr, name, fn, opts or {})
end

local Job = require "plenary.job"

-- Source: 🔭 utils: https://git.io/JK3ht
function M.get_os_command_output(cmd, cwd)
  if type(cmd) ~= "table" then
    print "Utils: [get_os_command_output]: cmd has to be a table"
    return {}
  end
  local command = table.remove(cmd, 1)
  local stderr = {}
  local stdout, ret = Job
    :new({
      command = command,
      args = cmd,
      cwd = cwd,
      on_stderr = function(_, data)
        table.insert(stderr, data)
      end,
    })
    :sync()
  return stdout, ret, stderr
end

function M.difference(a, b)
  local aa = {}
  for _, v in pairs(a) do
      aa[v] = true
  end
  for _, v in pairs(b) do
      aa[v] = nil
  end
  local ret = {}
  local n = 0
  for _, v in pairs(a) do
      if aa[v] then
          n = n + 1
          ret[n] = v
      end
  end
  return ret
end

return M