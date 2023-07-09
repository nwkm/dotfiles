local map = vim.keymap.set
local silent = { silent = true }

-- Switch to Normal Mode with jj
map("i", "jj", "<ESC>", silent)

-- Better window movement
map("n", "<C-h>", "<C-w>h", silent)
map("n", "<C-j>", "<C-w>j", silent)
map("n", "<C-k>", "<C-w>k", silent)
map("n", "<C-l>", "<C-w>l", silent)

-- H to move to the first non-blank character of the line
map({ 'n', 'v', 'o' }, 'H', '^', { desc = 'Move to beginning of line' })
-- L to move to the last non-blank character of the line
map({ 'n', 'v', 'o' }, 'L', '$', { desc = 'Move to end of line' })

-- Move current line / block with Alt-j/k a la vscode.
map("n", "<A-j>", ":m .+1<CR>==", silent)
map("n", "<A-k>", ":m .-2<CR>==", silent)
map("i", "<A-j>", "<Esc>:m .+1<CR>==", silent)
map("i", "<A-k>", "<Esc>:m .-2<CR>==", silent)

-- Move selected line / block of text in visual mode
map("x", "K", ":move '<-2<CR>gv-gv", silent)
map("x", "J", ":move '>+1<CR>gv-gv", silent)

-- Quit neovim
map("n", "<leader>Q", ":qa<CR>", silent)
map("n", "<leader>q", ":q<CR>", silent)

-- Quick write
map("n", "<leader>w", ":w<CR>", silent)

-- Resize splits with arrow keys
map("n", "<A-up>", ":vertical resize +1<CR>", silent)
map("n", "<A-down>", ":vertical resize -1<CR>", silent)
map("n", "<A-right>", ":resize +1<CR>", silent)
map("n", "<A-left>", ":resize -1<CR>", silent)

-- Keep visual mode indenting
map("v", "<", "<gv", silent)
map("v", ">", ">gv", silent)

-- Case change in visual mode
map("v", "`", "u", silent)
map("v", "<A-`>", "U", silent)

-- Remove highlights
map("n", "<CR>", ":noh<CR><CR>", silent)

-- Buffers
map("n", "<A-l>", ":bnext<CR>", silent)
map("n", "<A-h>", ":bprev<CR>", silent)

-- Don't yank on delete char
map("n", "x", '"_x', silent)
map("n", "X", '"_X', silent)
map("v", "x", '"_x', silent)
map("v", "X", '"_X', silent)

-- Don't yank on visual paste
map("v", "p", '"_dP', silent)

-- Avoid issues because of remapping <c-a> and <c-x> below
vim.cmd [[
  nnoremap <Plug>SpeedDatingFallbackUp <c-a>
  nnoremap <Plug>SpeedDatingFallbackDown <c-x>
]]

-- Quickfix
map("n", "<Space>,", ":cp<CR>", silent)
map("n", "<Space>.", ":cn<CR>", silent)

-- Toggle quicklist
-- map("n", "<Leader>q", "<cmd>lua require('utils').toggle_quicklist()<CR>", silent)

-- Manually invoke speeddating in case switch.vim didn't work
-- map("n", "<C-a>", ":if !switch#Switch() <bar> call speeddating#increment(v:count1) <bar> endif<CR>", silent)
-- map("n", "<C-x>", ":if !switch#Switch({'reverse': 1}) <bar> call speeddating#increment(-v:count1) <bar> endif<CR>", silent)

-- Open links under cursor in browser with gx
if vim.fn.has('macunix') == 1 then
  map("n", "gx", "<cmd>silent execute '!open ' . shellescape('<cWORD>')<CR>", silent)
else
  map("n", "gx", "<cmd>silent execute '!xdg-open ' . shellescape('<cWORD>')<CR>", silent)
end

-- LSP
map("n", "<Leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", silent)
map("v", "<Leader>ca", "<cmd>'<,'>lua vim.lsp.buf.code_action()<CR>", silent)
map("n", "<Leader>cr", "<cmd>lua vim.lsp.buf.rename()<CR>", silent)
map("n", "<Leader>cf", "<cmd>lua vim.lsp.buf.format({ async = true })<CR>", silent)
map("v", "<Leader>cf", "<cmd>'<.'>lua vim.lsp.buf.range_formatting()<CR>", silent)
map("n", "<Leader>cl", "<cmd>lua vim.diagnostic.open_float({ border = 'rounded', max_width = 100 })<CR>", silent)
map("n", "gl", "<cmd>lua vim.diagnostic.open_float({ border = 'rounded', max_width = 100 })<CR>", silent)
map("n", "]g", "<cmd>lua vim.diagnostic.goto_next({ float = { border = 'rounded', max_width = 100 }})<CR>", silent)
map("n", "[g", "<cmd>lua vim.diagnostic.goto_prev({ float = { border = 'rounded', max_width = 100 }})<CR>", silent)
map("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", silent)
map("n", "U", "<cmd>lua vim.lsp.buf.signature_help()<CR>", silent)

-- nvim-hlslens keymaps
map("n", "n", [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]], silent)
map("n", "N", [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]], silent)
map("n", "*", [[*<Cmd>lua require('hlslens').start()<CR>]], silent)
map("n", "#", [[#<Cmd>lua require('hlslens').start()<CR>]], silent)
map("n", "g*", [[g*<Cmd>lua require('hlslens').start()<CR>]], silent)
map("n", "g#", [[g#<Cmd>lua require('hlslens').start()<CR>]], silent)

-- Telescope
map("n", "<C-p>", "<CMD>lua require('plugins.telescope.pickers').project_files({ previewer = false })<CR>")
map("n", "<S-p>", "<CMD>lua require('plugins.telescope.multi-rg')()<CR>")

-- Toggleterm.nvim keymap
map("n", [[<C-\>]], ":ToggleTerm<CR>", silent)

function _G.set_terminal_keymaps()
  local opts = {buffer = 0}
  map('t', '<esc>', [[<C-\><C-n>]], opts)
  map('t', 'jj', [[<C-\><C-n>]], opts)
  map('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
  map('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
  map('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
  map('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
  map('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')
