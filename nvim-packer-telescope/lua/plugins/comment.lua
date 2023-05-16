local ok, comment = pcall(require, "Comment")
if not ok then
	return
end

comment.setup()

local map = vim.keymap.set

-- Linewise toggle current line using C-/
map('n', '<C-_>', '<CMD>lua require("Comment.api").toggle_current_linewise()<CR>')

-- Linewise toggle using C-/
map('x', '<C-_>', '<ESC><CMD>lua require("Comment.api").toggle_linewise_op(vim.fn.visualmode())<CR>')