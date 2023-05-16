local g = vim.g
local title = vim.env.SHELL

g.floaterm_width = 0.7
g.floaterm_height = 0.8
g.floaterm_title = '[' .. title .. ']:($1/$2)'
g.floaterm_borderchars = '─│─│╭╮╯╰'
g.floaterm_opener = 'vsplit'

local nmap = require('config.utils').nmap
local tmap = require('config.utils').tmap
local set_highlight = require('config.utils').set_highlight

nmap('<C-y>', ':FloatermToggle<cr>')
tmap('<C-y>', [[<C-\><C-n>:FloatermToggle<CR>]])
tmap('<C-w>l', [[<C-\><C-n>:FloatermNext<CR>]])
tmap('<C-w>h', [[<C-\><C-n>:FloatermPrev<CR>]])
tmap('<C-w>n', [[<C-\><C-n>:FloatermNew<CR>]])
tmap('<C-w>q', [[<C-\><C-n>:FloatermKill<CR>]])
nmap('<leader>lg', ':FloatermNew lazygit<CR>')

-- terminal highlights
set_highlight('FloatBorder', {
  guibg = 'None',
})

vim.cmd('hi! link FloatermBorder FloatBorder')

