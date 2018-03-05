set nocompatible
syntax off
filetype off

set directory=~/.vim/tmp
set rtp+=~/.fzf  "/usr/local/opt/fzf
set runtimepath+=~/.vim/plugged/swift.vim

call plug#begin()          " required

Plug 'terryma/vim-smooth-scroll'
Plug 'vim-airline/vim-airline'
Plug 'bronson/vim-trailing-whitespace'
Plug 'Yggdroot/indentLine'
Plug 'scrooloose/nerdcommenter' ",  {'on': 'NERDTreeToggle'}
Plug 'scrooloose/nerdtree'
"Plug 'tmux-plugins/vim-tmux'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-ragtag'
Plug 'tpope/vim-surround'
Plug 'alvan/vim-closetag'
Plug 'mhinz/vim-startify'
Plug 'edkolev/tmuxline.vim'
Plug 'chemzqm/vim-jsx-improve'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/gv.vim'
Plug 'ryanoasis/vim-devicons'
Plug 'leafgarland/typescript-vim'
Plug 'mattn/emmet-vim'
Plug 'udalov/kotlin-vim'

call plug#end()            " required

filetype on

" fuzzy file finder
let g:fzf_action = {
      \ 'ctrl-s': 'split',
      \ 'ctrl-v': 'vsplit'
      \ }
nnoremap <C-p> :FZF<cr>
let $FZF_DEFAULT_COMMAND = 'ag -g ""'

" emmet-vim
let g:user_emmet_install_global = 0
let g:user_emmet_settings = {
  \  'javascript.jsx' : {
    \      'extends' : 'js',
    \  },
  \}
augroup emmet
  autocmd!
  autocmd FileType html,css,javascript.jsx EmmetInstall
  autocmd FileType html,hbs,javascript.jsx,handlebars,css,scss imap <expr> <tab> emmet#expandAbbrIntelligent("\<tab>")
augroup END

" https://stackoverflow.com/questions/16902317/vim-slow-with-ruby-syntax-highlighting
set re=1

" indentLine
let g:indentLine_char = '¦'

" vim-jsx
"let g:jsx_ext_required = 0

" vim-airline
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
"let g:airline_left_sep = ''
"let g:airline_right_sep = ''
"let g:airline_left_sep= '░'
"let g:airline_right_sep= '░'
"let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
"let g:airline#extensions#tabline#left_sep = '░'
"let g:airline#extensions#tabline#left_sep = ''
"let g:airline#extensions#tabline#left_alt_sep = '|'

" vim-devicons
"autocmd FileType nerdtree setlocal nolist
"let g:WebDevIconsUnicodeDecorateFolderNodes=1
let g:WebDevIconsNerdTreeAfterGlyphPadding=''
"let g:WebDevIconsNerdTreeGitPluginForceVAlign=0
"let g:webdevicons_conceal_nerdtree_brackets = 0

" NerdTree
let NERDTreeShowHidden=1
let NERDTreeIgnore=[
    \ '.git$[[dir]]',
    \ '.vscode$[[dir]]',
    \ '.idea$[[dir]]',
    \ '.DS_Store$[[file]]',
    \ '.swp$[[file]]',
    \ '.pyc$[[file]]'
    \ ]
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1

" vim-startify
let g:startify_session_dir='~/.vim/session'
let g:startify_list_order=[
    \ ['   My sessions:'],
    \ 'sessions',
    \ ['   My most recently used files in the current directory:'],
    \ 'dir',
    \ ['   My most recently used files'],
    \ 'files',
    \ ['   My bookmarks:'],
    \ 'bookmarks',
    \ ['   My commands:'],
    \ 'commands',
\ ]

"let g:startify_session_before_save = [
    "\ 'echo "Cleaning up before saving.."',
    "\ 'silent! NERDTreeClose'
"\ ]

" Tmuxline
let g:tmuxline_theme = 'vim-powerline'
let g:tmuxline_preset = 'tmux'
let g:tmuxline_powerline_separators = 0

" Few configurations:
" set mouse=a //allow mouse use in vim!!
set nobackup
set encoding=utf-8
set hlsearch
set ffs=unix,dos,mac
set modeline
set autoindent
"set shiftwidth=2
set shiftwidth=4
set linebreak
set backspace=indent,eol,start
set laststatus=2
set cpoptions+=n
set number
set vb
" Set Tab as 2 spaces
set tabstop=2 expandtab
"set clipboard=unnamed              " copy selection to macOS clipboard
if $TMUX == ''
    set clipboard=unnamed
endif

"hi LineNr term=bold cterm=NONE ctermfg=DarkGrey ctermbg=235 gui=NONE guifg=NONE guibg=NONE
" Cursor line highlight
"hi CursorLine cterm=NONE ctermbg=NONE ctermfg=NONE guibg=NONE guifg=NONE
"hi CursorColumn term=NONE ctermbg=NONE ctermfg=NONE
set cursorline
set cursorcolumn
set belloff=all

syntax enable
"colorscheme custom
set background=dark

"colorscheme monokai-inspired
colorscheme turtles
"colorscheme default

" yaml indentation
au FileType yaml setlocal tabstop=2 expandtab shiftwidth=2 softtabstop=2

" Syntax highlighting
"let g:monokai_term_italic = 1

"set termguicolors
"colorscheme quantum
"let g:quantum_italics=1
"let g:airline_theme='turtles'
"let g:quantum_italics=1

" list all TODO and FIXME
"command Todo noautocmd vimgrep /TODO\|FIXME/j ** | cw
" Display whitespace
set list
set listchars=tab:»·,eol:¬,extends:>,precedes:<,trail:·
"highlight Normal ctermbg=0
" Open file under cursor in new tab


" Set key work in tmux
if &term =~ '^screen' && exists('$TMUX') || &term =~ '^tmux'
    set mouse=a
    " tmux knows the extended mouse mode
    set ttymouse=xterm2
    " tmux will send xterm-style keys when xterm-keys is on
    execute "set <xUp>=\e[1;*A"
    execute "set <xDown>=\e[1;*B"
    execute "set <xRight>=\e[1;*C"
    execute "set <xLeft>=\e[1;*D"
    execute "set <xHome>=\e[1;*H"
    execute "set <xEnd>=\e[1;*F"
    execute "set <Insert>=\e[2;*~"
    execute "set <Delete>=\e[3;*~"
    execute "set <PageUp>=\e[5;*~"
    execute "set <PageDown>=\e[6;*~"
    execute "set <xF1>=\e[1;*P"
    execute "set <xF2>=\e[1;*Q"
    execute "set <xF3>=\e[1;*R"
    execute "set <xF4>=\e[1;*S"
    execute "set <F5>=\e[15;*~"
    execute "set <F6>=\e[17;*~"
    execute "set <F7>=\e[18;*~"
    execute "set <F8>=\e[19;*~"
    execute "set <F9>=\e[20;*~"
    execute "set <F10>=\e[21;*~"
    execute "set <F11>=\e[23;*~"
    execute "set <F12>=\e[24;*~"
endif

"noremap <silent> <c-u> :call smooth_scroll#up(&scroll, 25, 2)<CR>
"noremap <silent> <c-d> :call smooth_scroll#down(&scroll, 25, 2)<CR>
"noremap <silent> <c-b> :call smooth_scroll#up(&scroll*2, 25, 4)<CR>
"noremap <silent> <c-f> :call smooth_scroll#down(&scroll*2, 25, 4)<CR>
source ~/.vim/startup/mappings.vim
source ~/.vim/startup/functions.vim
"source ~/.vim/startup/emmet.vim
