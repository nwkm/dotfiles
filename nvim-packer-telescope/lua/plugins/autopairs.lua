local ok, npairs = pcall(require, "nvim-autopairs")
if not ok then
	return
end

local rule = require('nvim-autopairs.rule')
local utils = require('nvim-autopairs.utils')
local cond = require('nvim-autopairs.conds')

npairs.setup({
    check_ts = true,
	map_cr = true,
	-- disable_filetype = { 'TelescopePrompt', 'UIPrompt' },
    -- ignored_next_char = '[%w%.%{%[%(%"%\']',
})

-- npairs.add_rules({
	-- before   insert  after
    --  (|)     ( |)	( | )
    -- rule(' ', ' ')
    --     :with_pair(function (opts)
    --     local pair = opts.line:sub(opts.col - 1, opts.col)
    --     return vim.tbl_contains({ '()', '[]', '{}' }, pair)
    --     end),
    -- rule('( ', ' )')
    --     :with_pair(function() return false end)
    --     :with_move(function(opts)
    --         return opts.prev_char:match('.%)') ~= nil
    --     end)
    --     :use_key(')'),
    -- rule('{ ', ' }')
    --     :with_pair(function() return false end)
    --     :with_move(function(opts)
    --         return opts.prev_char:match('.%}') ~= nil
    --     end)
    --     :use_key('}'),
    -- rule('[ ', ' ]')
    --     :with_pair(function() return false end)
    --     :with_move(function(opts)
    --         return opts.prev_char:match('.%]') ~= nil
    --     end)
    --     :use_key(']'),
    -- --[===[
    -- arrow key on javascript
    -- Before 	Insert    After
    -- (item)= 	> 	    (item)=> { }
    -- --]===]
    -- rule('%(.*%)%s*%=>$', ' {  }', { 'typescript', 'typescriptreact', 'javascript' })
    --     :use_regex(true)
    --     :set_end_pair_length(2),
-- })
