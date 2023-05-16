local map = vim.keymap.set

map('i', 'jj', '<Esc>')
-- ** Key Mappings ***
-- *TelEscope-related maps at telEscope/mappings (for now)

-- *Quickly surround Words*
-- filetype specific quick surrounds in ftps
-- vS to surround selection with argument
-- cs'" will change single to double quotes. Flip or change surroundings as needed.
-- ds{surrounding} to remove surroundings
-- Surround word under cursor w/ backticks (required vim-surround)
-- map('n', '<Leader>`', 'ysiw`', { noremap = true })
-- Surround word under cursor w/ double quotes (required vim-surround)
-- map('n', '""', 'ysiw"', { noremap = false })
-- Surround word under cursor w/ single quotes (required vim-surround)
-- map('n', "<Leader>'", "ysiW'", { noremap = false })
-- nmap( "''", "ysiw'", { noremap = false })
vim.cmd([[
  nmap "" ysiW"
  nmap '' ysiW'
  nmap `` ysiW`
]])
-- copy plus register contents to "c reqister
-- map('n', '<Leader>c', [[<Cmd>let @c=@+<CR>]])
-- paste from "c
map('n', '<Leader>p', '"cp')
-- REPLACE: cut inner word to "r & replace with last yanked (including system)
-- Or, visually select and p
map('n', ',r', '"rdiwhp')
-- DELETE: with y,d or c{motion} & it wont replace "0
map('n', '_', '"_')
-- paste last thing yanked(not system copied), not deleted
map('n', ',p', '"0p')
map('n', ',P', '"0P')

-- keep visual selection when (de)indenting
map('v', '<', '<gv', { desc = 'Keep visual mode on dedent' })
map('v', '>', '>gv', { desc = 'Keep visual mode on indent' })

-- open quickfix / close
map('n', '<Leader>co', ':cope<CR>')
map('n', '<Leader>cl', ':cclose<CR>')

map('n', '<Leader>v', ':vsplit<CR>')
map('n', '<Leader>s', ':split<CR>')
-- map('n', '<Leader>n', ':tabnew<CR>')
-- tabs
-- u.nmap("<LocalLeader>t", ":tabnew<CR>")
-- u.nmap("<LocalLeader>x", ":tabclose<CR>")
-- u.nmap("<LocalLeader>o", ":tabonly<CR>")
-- u.nmap("<LocalLeader>e", function()
--     local start_tab = vim.api.nvim_tabpage_get_number(0)

--     vim.cmd("tabedit %")
--     local new_tab = vim.api.nvim_tabpage_get_number(0)

--     vim.cmd(string.format("%dtabdo b#", start_tab))
--     vim.cmd(string.format("normal %dgt", new_tab))
-- end)
-- u.nmap("<LocalLeader>v", ":vsplit %<CR>")
-- u.nmap("<LocalLeader>s", ":split %<CR>")

-- save
map('n', '<Leader>w', '<Esc>:update<CR>')
map('v', '<Leader>w', '<Esc>:update<CR>')

-- quit
map('n', '<Leader>q', ':q<CR>')
map('n', '<Leader>Q', ':q!<CR>')

map('n', '<Leader><Up>',    "<Cmd>lua require'utils'.resize(false, -5)<CR>")
map('n', '<Leader><Down>',  "<Cmd>lua require'utils'.resize(false,  5)<CR>")
map('n', '<Leader><Left>',  "<Cmd>lua require'utils'.resize(true,  -5)<CR>")
map('n', '<Leader><Right>', "<Cmd>lua require'utils'.resize(true,   5)<CR>")

-- Move current line / block with Alt-j/k
map("n", "<A-j>", ":m .+1<CR>==")
map("n", "<A-k>", ":m .-2<CR>==")
map("i", "<A-j>", "<Esc>:m .+1<CR>==")
map("i", "<A-k>", "<Esc>:m .-2<CR>==")

-- Move around splits using Ctrl + {h,j,k,l}
map('n', '<C-h>', '<C-w>h')
map('n', '<C-j>', '<C-w>j')
map('n', '<C-k>', '<C-w>k')
map('n', '<C-l>', '<C-w>l')

-- Auto pair
-- map('i', '{<Enter>', '{<Enter>}<Esc>O')

map('n', '<Esc>', ':nohl<CR>')

map({ 'n', 'v', 'o' }, 'H', '^', { desc = 'Move to beginning of line' })
map({ 'n', 'v', 'o' }, 'L', '$', { desc = 'Move to end of line' })
