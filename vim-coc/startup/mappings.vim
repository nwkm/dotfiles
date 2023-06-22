" Use space as the leader key
let mapleader="\<Space>"

" Call functions
nnoremap <leader>t :call OpenUnderTab()<CR>

" Auto pair
imap ( ()<left>
imap { {}<left>
imap [ []<left>

nmap "" ysiW"
nmap '' ysiW'
nmap `` ysiW`

" Move line
nnoremap <S-Up> :m-2<CR>
nnoremap <S-Down> :m+<CR>
inoremap <S-Up> <Esc>:m-2<CR>
inoremap <S-Down> <Esc>:m+<CR>

" Navigate split panes
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Go to tab by number
noremap <leader>1 1gt
noremap <leader>2 2gt
noremap <leader>3 3gt
noremap <leader>4 4gt
noremap <leader>5 5gt

" Remap escape
inoremap jj <ESC>

nmap H ^
vmap H ^
omap H ^
nmap L $
vmap L $
omap L $

" Indent selected text
vnoremap <Tab> >
vnoremap <S-Tab> <

" Clear highlighting by hitting enter
nnoremap <CR> :noh<CR><CR>
"nnoremap <ESC> :noh<RETURN><ESC>


" Navigate buffers
nnoremap <leader>] :bnext<CR>
nnoremap <leader>[ :bprev<CR>

" NERDTreeCommenter
nmap <C-_> <leader>c<Space>
vmap <C-_> <leader>c<Space>

" Delete (cut) to clipboard.
"vnoremap <leader>x "*x
"nnoremap <leader>x "*x

"" Yank (copy) to clipboard.
"vnoremap <leader>y "*y
"nnoremap <leader>y "*y

"" Put (paste) from clipboard.
"nnoremap <leader>p "*p
"vnoremap <leader>p "*p
"nnoremap <leader><S-p> "*P
"vnoremap <leader><S-p> "*P

nnoremap Y y$

nnoremap n nzzzv
nnoremap N Nzzzv

" Window resizing
nnoremap <silent> <leader>= :exe "resize " . (winheight(0) * 3/2)<CR>
nnoremap <silent> <leader>- :exe "resize " . (winheight(0) * 2/3)<CR>
noremap <silent> <leader>0 :exe "vertical resize " . (winwidth(0) * 3/2)<CR>
nnoremap <silent> <leader>9 :exe "vertical resize " . (winwidth(0) * 2/3)<CR>
noremap <C-t> :NERDTreeToggle<CR>

"noremap <C-f> :NERDTreeFind<CR>     " Open NERDTree and focus on current file
noremap <F5> :e!<CR>                   " force reload current file

nnoremap <leader>w :w<CR>              " save file
nnoremap <leader>q :q<CR>              " it quit vim window
nnoremap <leader>b :bp\|bd #<CR>       " close current buffer

noremap <leader>Q :q!<CR>              " it force quit current vim buffer
noremap <leader>v :vertical :new<CR>   " open new vertical window
noremap <leader>h :new<CR>             " open a new horizontal window
noremap <leader>n :tabnew<CR>          " create a new tab

" FZF
nnoremap <silent> <C-p> :GFiles<CR>
nnoremap <silent> \ :Rg <C-R><C-W><CR>
nnoremap <silent> <C-o> :Files<CR>
nnoremap <silent> <C-m> :RG<CR>
nnoremap <silent> <C-b> :Buffers<CR>
nnoremap <silent> <Leader>/ :BLines<CR>
nnoremap <silent> <Leader>' :Marks<CR>
nnoremap <silent> <Leader>g :Commits<CR>
nnoremap <silent> <Leader>H :Helptags<CR>
nnoremap <silent> <Leader>hh :History<CR>
nnoremap <silent> <Leader>h: :History:<CR>
nnoremap <silent> <Leader>h/ :History/<CR>

nnoremap <silent> K :call CocAction('doHover')<CR>
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
" Remap keys for applying codeAction to the current buffer.
nmap <leader>do  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>fc  <Plug>(coc-fix-current)

" Format
nmap <leader>pf :CocCommand prettier.formatFile<CR>

" Floaterm
noremap <leader>lg :FloatermNew lazygit<CR>


