local o = vim.opt
local g = vim.g

o.mouse             = 'a'        -- disable the mouse
o.exrc              = false     -- ignore '~/.exrc'
o.secure            = true
o.modelines         = 1         -- read a modeline at EOF
o.errorbells        = false     -- disable error bells (no beep/flash)
o.termguicolors     = true      -- enable 24bit colors

o.updatetime        = 250       -- decrease update time
o.autoread          = true      -- auto read file if changed outside of vim
o.fileformat        = 'unix'    -- <nl> for EOL
o.switchbuf         = 'useopen'
o.encoding          = 'utf-8'
o.fileencoding      = 'utf-8'
o.backspace         = { 'eol', 'start', 'indent' }
o.matchpairs        = { '(:)', '{:}', '[:]', '<:>' }
o.number			= true
o.relativenumber	= true
o.numberwidth		= 6
o.wrap              = true      -- wrap long lines
o.breakindent       = true      -- start wrapped lines indented
o.linebreak         = true      -- do not break words on line wrap
o.list 				= true
o.listchars   = {
    tab       = '→·'  ,
    eol       = '¬'   ,
    nbsp      = '␣'   ,
    trail     = '•'   ,
    extends   = '⟩'   ,
    precedes  = '⟨'   ,
}
o.showbreak = '↪ '

o.tabstop           = 4         -- Tab indentation levels every two columns
o.softtabstop       = 4         -- Tab indentation when mixing tabs & spaces
o.shiftwidth        = 4         -- Indent/outdent by two columns
o.shiftround        = true      -- Always indent/outdent to nearest tabstop
o.expandtab         = true      -- Convert all tabs that are typed into spaces
o.smarttab          = true      -- Use shiftwidths at left margin, tabstops everywhere else

o.backup            = false     -- no backup file
o.writebackup       = false     -- do not backup file before write
o.swapfile          = false     -- no swap file

o.autoindent        = true      -- copy indent from current line on newline
o.smartindent       = true      -- add <tab> depending on syntax (C/C++)

-- Map leader to <space>
g.mapleader      	= ' '
g.maplocalleader 	= ';'

--vim.cmd[[colorscheme monokai-inspired]]
