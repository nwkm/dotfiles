local map = require'utils'.remap
local command = require'utils'.command
local opts = { noremap = true }
local default = { noremap = true, silent = true }

-- Shortcuts for editing the keymap file and reloading the config
vim.cmd [[command! -nargs=* NvimEditInit split | edit $MYVIMRC]]
vim.cmd [[command! -nargs=* NvimEditKeymap split | edit ~/.config/nvim/lua/keymaps.lua]]
vim.cmd [[command! -nargs=* NvimSourceInit luafile $MYVIMRC]]

-- Use ':Grep' or ':LGrep' to grep into quickfix|loclist
-- without output or jumping to first match
-- Use ':Grep <pattern> %' to search only current file
-- Use ':Grep <pattern> %:h' to search the current file dir
vim.cmd("command! -nargs=+ -complete=file Grep " ..
    "lua vim.api.nvim_exec([[noautocmd grep! <args> | redraw! | copen]], true)")
vim.cmd("command! -nargs=+ -complete=file LGrep " ..
    "lua vim.api.nvim_exec([[noautocmd lgrep! <args> | redraw! | lopen]], true)")

map('', '<leader>ei', '<Esc>:NvimEditInit<CR>',   { silent = true })
map('', '<leader>ek', '<Esc>:NvimEditKeymap<CR>', { silent = true })
map('', '<leader>R',  "<Esc>:NvimRestart<CR>",    { silent = true })

-- Fix common typos
vim.cmd([[
    cnoreabbrev W! w!
    cnoreabbrev W1 w!
    cnoreabbrev w1 w!
    cnoreabbrev Q! q!
    cnoreabbrev Q1 q!
    cnoreabbrev q1 q!
    cnoreabbrev Qa! qa!
    cnoreabbrev Qall! qall!
    cnoreabbrev Wa wa
    cnoreabbrev Wq wq
    cnoreabbrev wQ wq
    cnoreabbrev WQ wq
    cnoreabbrev wq1 wq!
    cnoreabbrev Wq1 wq!
    cnoreabbrev wQ1 wq!
    cnoreabbrev WQ1 wq!
    cnoreabbrev W w
    cnoreabbrev Q q
    cnoreabbrev Qa qa
    cnoreabbrev Qall qall
]])

-- Press jj to exit
map('i', 'jj', '<Esc>', opts)

-- save
map('n', '<leader>w', '<Esc>:update<cr>', { silent = true })
map('v', '<leader>w', '<Esc>:update<cr>', { silent = true })

-- quit
map('n', '<leader>q', ':q<CR>', opts)
map('n', '<leader>Q', ':q!<CR>', opts)
map('n', '<leader>b', ':bp | bd #<CR>', default)

-- w!! to save with sudo
map('c', 'w!!', "<esc>:lua require'utils'.sudo_write()<CR>", { silent = true })

-- Beginning and end of line in `:` command mode
map('c', '<c-a>', '<home>', {})
map('c', '<c-e>', '<end>' , {})
-- Arrows in command line mode (':') menus
map('c', '<down>', '(pumvisible() ? "\\<C-n>" : "\\<down>")', { noremap = true, expr = true })
map('c', '<up>',   '(pumvisible() ? "\\<C-p>" : "\\<up>")',   { noremap = true, expr = true })

-- Terminal mappings
map('t', '<m-[>', [[<C-\><C-n>]],      { noremap = true })
map('t', '<c-w>', [[<C-\><C-n><C-w>]], { noremap = true })
map('t', '<m-r>', [['<C-\><C-N>"'.nr2char(getchar()).'pi']], default)

-- tmux like directional window resizes
map('n', '<leader><Up>',    "<cmd>lua require'utils'.resize(false, -5)<CR>", { noremap = true, silent = true })
map('n', '<leader><Down>',  "<cmd>lua require'utils'.resize(false,  5)<CR>", { noremap = true, silent = true })
map('n', '<leader><Left>',  "<cmd>lua require'utils'.resize(true,  -5)<CR>", { noremap = true, silent = true })
map('n', '<leader><Right>', "<cmd>lua require'utils'.resize(true,   5)<CR>", { noremap = true, silent = true })
map('n', '<leader>=',       '<C-w>=',               { noremap = true, silent = true })

-- Tab navigation
map('n', '<Leader>tp', ':tabprevious<CR>', { noremap = true })
map('n', '<Leader>tn', ':tabnext<CR>',     { noremap = true })
map('n', '<Leader>tf', ':tabfirst<CR>',    { noremap = true })
map('n', '<Leader>tl', ':tablast<CR>',     { noremap = true })
map('n', '<Leader>tN', ':tabnew<CR>',      { noremap = true })
map('n', '<Leader>tc', ':tabclose<CR>',    { noremap = true })
-- Jump to first tab & close all other tabs. Helpful after running Git difftool.
map('n', '<Leader>to',  ':tabfirst<CR>:tabonly<CR>', { noremap = true })
-- tmux <c-meta>z like
map('n', '<Leader>tz',  "<cmd>lua require'utils'.tabedit()<CR>", { noremap = true })
map('n', '<Leader>tZ',  "<cmd>lua require'utils'.tabclose()<CR>", { noremap = true })

-- Navigate buffers
map("n", "<S-l>", ":bnext<CR>", opts)
map("n", "<S-h>", ":bprevious<CR>", opts)
map('n', '[B', ':bfirst<CR>',         { noremap = true })
map('n', ']B', ':blast<CR>',          { noremap = true })
-- Quickfix list mappings
--map('n', '<leader>q', "<cmd>lua require'utils'.toggle_qf('q')<CR>", { noremap = true })
map('n', '[q', ':cprevious<CR>',      { noremap = true })
map('n', ']q', ':cnext<CR>',          { noremap = true })
map('n', '[Q', ':cfirst<CR>',         { noremap = true })
map('n', ']Q', ':clast<CR>',          { noremap = true })
-- Location list mappings
--map('n', '<leader>Q', "<cmd>lua require'utils'.toggle_qf('l')<CR>", { noremap = true })
map('n', '[l', ':lprevious<CR>',      { noremap = true })
map('n', ']l', ':lnext<CR>',          { noremap = true })
map('n', '[L', ':lfirst<CR>',         { noremap = true })
map('n', ']L', ':llast<CR>',          { noremap = true })
-- Tags / Preview tags
map('n', '[t', ':tprevious<CR>',      { noremap = true })
map('n', ']t', ':tNext<CR>',          { noremap = true })
map('n', '[T', ':tfirst<CR>',         { noremap = true })
map('n', ']T', ':tlast<CR>',          { noremap = true })
map('n', '[p', ':ptprevious<CR>',     { noremap = true })
map('n', ']p', ':ptnext<CR>',         { noremap = true })
--remap('n', '<Leader>ts', ':<C-u>tselect <C-r><C-w><CR>', { noremap = true })

-- <leader>v|<leader>s act as <cmd-v>|<cmd-s>
-- <leader>p|P paste from yank register (0)
--map('n', '<leader>v', '"+p',      { noremap = true })
--map('n', '<leader>V', '"+P',      { noremap = true })
--map('v', '<leader>v', '"_d"+p',   { noremap = true })
--map('v', '<leader>v', '"_d"+P',   { noremap = true })
--map('n', '<leader>s', '"*p',      { noremap = true })
--map('n', '<leader>S', '"*P',      { noremap = true })
--map('v', '<leader>s', '"*p',      { noremap = true })
--map('v', '<leader>S', '"*p',      { noremap = true })

-- Overloads for 'd|c' that don't pollute the unnamed registers
-- In visual-select mode 'd=delete, x=cut (unchanged)'
map('n', '<leader>d',  '"_d',     { noremap = true })
map('n', '<leader>D',  '"_D',     { noremap = true })
map('n', '<leader>c',  '"_c',     { noremap = true })
map('n', '<leader>C',  '"_C',     { noremap = true })
map('v', '<leader>c',  '"_c',     { noremap = true })
map('v', 'd',          '"_d',     { noremap = true })

-- Map `Y` to copy to end of line
-- conistent with the behaviour of `C` and `D`
map('n', 'Y', 'y$',               { noremap = true })
map('v', 'Y', '<Esc>y$gv',        { noremap = true })

-- keep visual selection when (de)indenting
map('v', '<', '<gv', { noremap = true })
map('v', '>', '>gv', { noremap = true })

-- Move current line / block with Alt-j/k a la vscode.
map("n", "<A-j>", ":m .+1<CR>==", opts)
map("n", "<A-k>", ":m .-2<CR>==", opts)
map("i", "<A-j>", "<Esc>:m .+1<CR>==", opts)
map("i", "<A-k>", "<Esc>:m .-2<CR>==", opts)

-- Move around splits using Ctrl + {h,j,k,l}
map('n', '<C-h>', '<C-w>h', default)
map('n', '<C-j>', '<C-w>j', default)
map('n', '<C-k>', '<C-w>k', default)
map('n', '<C-l>', '<C-w>l', default)

-- split
map('n', '<leader>v', ':vsplit<CR>', default)
map('n', '<leader>x', ':split<CR>', default)
map('n', '<leader>n', ':tabnew<CR>', default)

-- Move selected lines up/down in visual mode
map('x', 'K', ":move '<-2<CR>gv=gv", { noremap = true })
map('x', 'J', ":move '>+1<CR>gv=gv", { noremap = true })

-- Select last pasted/yanked text
map('n', 'g<C-v>', '`[v`]', { noremap = true })

-- Keep matches center screen when cycling with n|N
map('n', 'n', 'nzzzv', { noremap = true })
map('n', 'N', 'Nzzzv', { noremap = true })

-- Break undo chain on punctuation so we can
-- use 'u' to undo sections of an edit
for _, c in ipairs({',', '.', '!', '?', ';'}) do
   map('i', c, c .. "<C-g>u", { noremap = true })
end

-- any jump over 5 modifies the jumplist
-- so we can use <C-o> <C-i> to jump back and forth
for _, c in ipairs({'j', 'k'}) do
  map('n', c, ([[(v:count > 5 ? "m'" . v:count : "") . '%s']]):format(c),
    { noremap=true, expr = true, silent = true})
end

-- move along visual lines, not numbered ones
-- without interferring with {count}<down|up>
for _, m in ipairs({'n', 'v'}) do
  for _, c in ipairs({'<up>', '<down>'}) do
    map(m, c, ([[v:count == 0 ? 'g%s' : '%s']]):format(c, c),
        { noremap=true, expr = true, silent = true})
  end
end

-- Search and Replace
-- 'c.' for word, '<leader>c.' for WORD
map('n', 'c.',         [[:%s/\<<C-r><C-w>\>//g<Left><Left>]], { noremap = true })
map('n', '<leader>c.', [[:%s/\<<C-r><C-a>\>//g<Left><Left>]], { noremap = true })

-- Turn off search matches with double-<Esc>
map('n', '<Esc><Esc>', '<Esc>:nohlsearch<CR>', { noremap = true, silent = true })

-- Toggle display of `listchars`
map('n', '<leader>\'', '<Esc>:set list!<CR>',   { noremap = true, silent = true })

-- Toggle colored column at 81
map('n', '<leader>|',
    ':execute "set colorcolumn=" . (&colorcolumn == "" ? "81" : "")<CR>',
    { noremap = true, silent = true })

-- Change current working dir (:pwd) to curent file's folder
map('n', '<leader>%', '<Esc>:cd %:h | pwd<CR>',   { noremap = true, silent = true })

-- Map <leader>o & <leader>O to newline without insert mode
map('n', '<leader>o',
    ':<C-u>call append(line("."), repeat([""], v:count1))<CR>',
    { noremap = true, silent = true })
map('n', '<leader>O',
    ':<C-u>call append(line(".")-1, repeat([""], v:count1))<CR>',
    { noremap = true, silent = true })

-- Map `cp` to `xp` (transpose two adjacent chars)
-- as a **repeatable action** with `.`
-- (since the `@=` trick doesn't work
-- nmap cp @='xp'<CR>
-- http://vimcasts.org/transcripts/61/en/
map('n', '<Plug>TransposeCharacters', [[xp:call repeat#set("\<Plug>TransposeCharacters")<CR>]], default)
map('n', 'cp', '<Plug>TransposeCharacters', {})

map('n', '<C-t>', ":NvimTreeToggle<CR>", { silent = true })
map('n', '<C-m>',  ":NvimTreeFindFile<CR>",   { silent = true })
