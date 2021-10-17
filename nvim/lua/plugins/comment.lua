local res, comment = pcall(require, "Comment")
if not res then
  return
end

local Ut = require('Comment.utils')
local Op = require('Comment.opfunc')

function _G.__toggle_visual(vmode)
    local lcs, rcs = Ut.unwrap_cstr(vim.bo.commentstring)
    local scol, ecol, lines = Ut.get_lines(vmode, Ut.ctype.line)

    Op.linewise({
        cfg = { padding = true, ignore = nil },
        cmode = Ut.cmode.toggle,
        lines = lines,
        lcs = lcs,
        rcs = rcs,
        scol = scol,
        ecol = ecol,
    })
end

--[[ vim.api.nvim_set_keymap(
    'x',
    '<C-_>',
    '<ESC><CMD>lua __toggle_visual(vim.fn.visualmode())<CR>',
    { noremap = true, silent = true }
)
vim.api.nvim_set_keymap("n", "<C-_>", "<CMD>lua require'Comment'.toggle()", {}) ]]

comment.setup({

  opleader = {
    line = 'gl',
    block = 'gc',
  },
  toggler = {
    ---line-comment toggle
    line = '<C-_>',
    ---block-comment toggle
    block = '<C-_>',
  },

  pre_hook = nil,
  post_hook = nil,
})
