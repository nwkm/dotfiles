local map = vim.keymap.set

-- Move to previous/next
map('n', '<A-,>', ':BufferPrevious<cr>')
map('n', '<A-.>', ':BufferNext<cr>')
-- Re-order to previous/next
map('n', '<A-<>', ':BufferMovePrevious<cr>')
map('n', '<A->>', ' :BufferMoveNext<cr>')
-- Close buffer
map('n', '<A-c>', ':BufferClose<cr>')