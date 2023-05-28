local present, wk = pcall(require, "which-key")
if not present then
  return
end

wk.setup {
  plugins = {
    marks = true, -- shows a list of your marks on ' and `
    registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
    -- the presets plugin, adds help for a bunch of default keybindings in Neovim
    -- No actual key bindings are created
    spelling = {
      enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
      suggestions = 20, -- how many suggestions should be shown in the list?
    },
    presets = { operators = false, -- adds help for operators like d, y, ... and registers them for motion / text object completion
      motions = false, -- adds help for motions text_objects = false, -- help for text objects triggered after entering an operator
      windows = false, -- default bindings on <c-w>
      nav = false, -- misc bindings to work with windows
      z = false, -- bindings for folds, spelling and others prefixed with z
      g = false, -- bindings for prefixed with g
    },
  },
  -- add operators that will trigger motion and text object completion
  -- to enable all native operators, set the preset / operators plugin above
  operators = { gc = "Comments" },
  key_labels = {
    -- override the label used to display some keys. It doesn't effect WK in any other way.
    -- For example:
    -- ["<space>"] = "SPC",
    -- ["<cr>"] = "RET",
    -- ["<tab>"] = "TAB",
  },
  icons = {
    breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
    separator = "➜", -- symbol used between a key and it's label
    group = "+", -- symbol prepended to a group
  },
  window = {
    border = nw.ui.float.border or "rounded", -- none, single, double, shadow, rounded
    position = "bottom", -- bottom, top
    margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
    padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
  },
  layout = {
    height = { min = 4, max = 25 }, -- min and max height of the columns
    width = { min = 20, max = 50 }, -- min and max width of the columns
    spacing = 4, -- spacing between columns
    align = "left", -- align columns left, center or right
  },
  ignore_missing = false, -- enable this to hide mappings for which you didn't specify a label
  hidden = { "<silent>", "<Cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ "}, -- hide mapping boilerplate
  show_help = true, -- show help message on the command line when the popup is visible
  -- triggers = "auto", -- automatically setup triggers
  triggers = {"<leader>"}, -- or specify a list manually
  triggers_blacklist = {
    -- list of mode / prefixes that should never be hooked by WhichKey
    -- this is mostly relevant for key maps that start with a native binding
    -- most people should not need to change this
    i = { "j", "k" },
    v = { "j", "k" },
  },
}

local normal_opts = {
  mode = "n", -- NORMAL mode
  prefix = "<leader>",
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = false, -- use `nowait` when creating keymaps
}

local visual_opts = {
  mode = "v", -- VISUAL mode
  prefix = "<leader>",
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = false, -- use `nowait` when creating keymaps
}

local normal_mode_mappings = {
  -- ignore
  ['1'] = 'which_key_ignore',
  ['2'] = 'which_key_ignore',
  ['3'] = 'which_key_ignore',
  ['4'] = 'which_key_ignore',
  ['5'] = 'which_key_ignore',
  ['6'] = 'which_key_ignore',
  ['7'] = 'which_key_ignore',
  ['8'] = 'which_key_ignore',
  ['9'] = 'which_key_ignore',

  -- single
  ['='] = { '<Cmd>vertical resize +5<CR>',                      'resize +5' },
  ['-'] = { '<Cmd>vertical resize -5<CR>',                      'resize -5' },
  ['v'] = { '<C-W>v',                                           'split right' },
  ['V'] = { '<C-W>s',                                           'split below' },

  ['e'] = 'Explorer',
  ['q'] = 'Quit the current file',
  ['Q'] = 'Quit neovim',
  ['w'] = 'Save the current file',
  ['o'] = 'Open symbols-outline.nvim',
  ['u'] = 'Open undo tree',

  ['/'] = {
    name = 'nw',
    -- ['/'] = { '<Cmd>Alpha<CR>',                                 'open dashboard' },
    c = { '<Cmd>e $MYVIMRC<CR>',                                'open config' },
    i = { '<Cmd>Lazy<CR>',                                      'manage plugins' },
    u = { '<Cmd>Lazy update<CR>',                               'update plugins' },
    s = {
      name = 'Session',
      c = { '<Cmd>SessionManager load_session<CR>',             'choose session' },
      r = { '<Cmd>SessionManager delete_session<CR>',           'remove session' },
      d = { '<Cmd>SessionManager load_current_dir_session<CR>', 'load current dir session' },
      l = { '<Cmd>SessionManager load_last_session<CR>',        'load last session' },
      s = { '<Cmd>SessionManager save_current_session<CR>',     'save session' },
    },
  },

  a = {
    name = 'Actions',
    n = { '<Cmd>set nonumber!<CR>',                      'line numbers' },
    r = { '<Cmd>set norelativenumber!<CR>',              'relative number' },
  },

  b = {
    name = 'Buffer',
    k = { "<Cmd>Bdelete<CR>", "Kill the current buffer" },
    K = { "<Cmd>Bdelete!<CR>", "Kill the current buffer forcefully"},
    w = { "<Cmd>Bwipeout<CR>", "Kill every other buffer"},
    W = { "<Cmd>Bwipeout!<CR>", "Kill every other buffer forcefully"},
  },

  c = {
    name = "LSP",
    a = { "Code action" },
    f = { "Format" },
    l = { "Line diagnostics" },
    r = { "Rename" },
    R = { "Structural replace" },
    d = { "<Cmd>TroubleToggle<CR>",                           "Diagnostics" },
    w = { "<Cmd>TroubleToggle<CR>",                           "Workspace diagnostics" },
    W = { "<Cmd>Telescope diagnostics wrap_results=true<CR>", "Workspace diagnostics (Telescope)" },
    t = { "<Cmd>LspToggleAutoFormat<CR>",                     "Toggle format on save" },
    s = { "<Cmd>TroubleToggle loclist<CR>",                   "Location list" },
    q = { "<Cmd>TroubleToggle quickfix<CR>",                  "Quickfix" },
    p = { "<Cmd>TroubleToggle lsp_references<CR>",            "Lsp references" },
  },

  d = {
    name = 'Debug',
    a = { 'attach' },
    b = { 'toggle breakpoint' },
    c = { 'continue' },
    C = { 'close UI' },
    h = { 'visual hover' },
    i = { 'step into' },
    o = { 'step over' },
    O = { 'step out' },
    r = { 'repl' },
    s = { 'scopes' },
    t = { 'terminate' },
    v = { 'log variable' },
    V = { 'log variable above' },
    w = { 'watches' },
    w = { 'watches' },
    d = { '<Cmd>Telescope dap configurations<CR>', 'configurations' },
    f = { '<Cmd>Telescope dap list_breakpoints<CR>', 'all breakpoints' }
  },

  g = {
    name = 'Git',
    a = { '<Cmd>!git add %:p<CR>',                                              'add current' },
    A = { '<Cmd>!git add .<CR>',                                                'add all' },
    b = { '<Cmd>lua require("internal.blame").open()<CR>',                      'blame' },
    c = {
      name = 'Conflict',
      b = {'<Cmd>GitConflictChooseBoth<CR>',                                    'choose both'},
      n = {'<Cmd>GitConflictNextConflict<CR>',                                  'move to next conflict'},
      o = {'<Cmd>GitConflictChooseOurs<CR>',                                    'choose ours'},
      p = {'<Cmd>GitConflictPrevConflict<CR>',                                  'move to prev conflict'},
      t = {'<Cmd>GitConflictChooseTheirs<CR>',                                  'choose theirs'},
    },
    d = { '<Cmd>lua require("plugins.git.git-diffview").toggle_file_history()<CR>', 'diff file' },
    g = { '<Cmd>LazyGit<CR>',                                                   'lazygit' },
    h = {
      name = 'Hunk',
      d = 'diff hunk',
      p = 'preview',
      R = 'reset buffer',
      r = 'reset hunk',
      s = 'stage hunk',
      S = 'stage buffer',
      t = 'toggle deleted',
      u = 'undo stage',
    },
    l = {
      name = 'Log',
      a = { "<Cmd>LazyGitFilter<CR>",                                      "Commits"},
      c = { "<Cmd>LazyGitFilterCurrentFile<CR>",                           "Buffer commits"},
      -- C = { "<Cmd>lua require('plugins.telescope.pickers').my_git_bcommits()<CR>", "Buffer commits (Telescope)"},
      -- A = { "<Cmd>lua require('plugins.telescope.pickers').my_git_commits()<CR>",  "Commits (Telescope)"},
    },
    m = { "Blame line" },
    n = { "<Cmd>Neogit<CR>", "Neogit" },
    s = { "<Cmd>lua require('plugins.git.git-diffview').toggle_status()<CR>", "Status" },
    
    -- n = { ":!git checkout -b ", "Checkout New Branch" },
    -- o = { "<cmd>Telescope git_status<cr>", "Open changed file" },
    -- b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
    -- 
    -- f = { "<cmd>Telescope git_bcommits<cr>", "Checkout buffer commit" },
    -- d = {
    --   "<cmd>Gitsigns diffthis HEAD<cr>",
    --   "Diff",
    -- },
    w = {
      name = "Worktree",
      w = "worktrees",
      c = "create worktree",
    }
  },

  f = {
    name = "Git (Telescope)",
    b = { "<Cmd>Telescope git_branches<CR>", "branches" },
    s = { "<Cmd>Telecope git_status<CR>",  "status" },
    c = { "<Cmd>lua require('plugins.telescope.pickers').my_git_commits()<CR>",  "commits"},
    u = { "<Cmd>lua require('plugins.telescope.pickers').my_git_bcommits()<CR>", "buffer commits"},
  },

  p = {
    name = "Project",
    f = { "<Cmd>lua require('plugins.telescope.pickers').project_files({ default_text = vim.fn.expand('<cword>'), initial_mode = 'normal' })<CR>", 'File' },
    w = { "<Cmd>lua require('telescope.builtin').grep_string({ initial_mode = 'normal' })", 'Word' },
    l = { "<Cmd>lua require'telescope'.extensions.repo.cached_list{file_ignore_patterns={'/%.cache/', '/%.cargo/', '/%.local/', '/%timeshift/', '/usr/', '/srv/', '/%.oh%-my%-zsh', '/Library/', '/%.cocoapods/'}}<CR>", 'List' },
    r = { "<Cmd>lua require('spectre').open_visual({select_word=true})<CR>",     "Refactor" },
    s = { "<Cmd>SessionManager save_current_session<CR>",            "Save session" },
    t = { "<Cmd>TodoTrouble<CR>",                                    "Todo" },
  },

  s = {
    name = "Search",
    -- c = { '<Cmd>Telescope colorscheme<CR>',                              'color schemes' },
    c = { "<Cmd>Telescope commands<CR>",                                 "Commands" },
    d = { '<Cmd>lua require("plugins.telescope.pickers").edit_neovim()<CR>', "Dotfiles" },
    f = { "<Cmd>lua require('telescope.builtin').find_files()<CR>",      "Find files" },
    t = { "<Cmd>Telescope live_grep <CR>",                               "Find texts" },
    h = { "<Cmd>Telescope help_tags<CR>",                                "Find Helps" },
    m = { "<Cmd>Telescope man_pages<CR>",                                "Man pages" },
    r = { "<Cmd>Telescope registers<CR>",                                "Registers" },
    k = { "<Cmd>Telescope keymaps<CR>",                                  "Keymaps" },
    y = { '<Cmd>Telescope files hidden=true<CR>',                     "Recent files" },
    s = { '<Cmd>Telescope search_history theme=dropdown<CR>',            "Histories" },
    H = { '<Cmd>lua require("plugins.telescope.pickers").command_history()<CR>', "Command histories" },
  },

  t = {
    name = 'Table Mode',
    m = { 'toggle' },
    t = { 'tableize' },
  },
}

local visual_mode_mappings = {
  -- single
  ["s"] = { "<Cmd>'<,'>sort<CR>",               'sort' },

  a = {
    name = "Actions",
  },

  c = {
    name = "LSP",
    a = { "range code action" },
    f = { "range format" },
  },

  g = {
    name = "Git",
    h = {
      name = "Hunk",
      r = "reset hunk",
      s = "stage hunk",
    },
  },

  p = {
    name = "Project",
    r = { "<Cmd>lua require('spectre').open_visual()<CR>",     "Refactor" },
  },

  t = {
    name = "Table Mode",
    t = { "tableize" },
  },
}

-- ╭──────────────────────────────────────────────────────────╮
-- │ Register                                                 │
-- ╰──────────────────────────────────────────────────────────╯

wk.register(normal_mode_mappings, normal_opts)
wk.register(visual_mode_mappings, visual_opts)

local function attach_markdown(bufnr)
  wk.register({
    a = {
      name = "Actions",
      m = { '<Cmd>MarkdownPreviewToggle<CR>', 'markdown preview' },
    }
  }, {
    buffer = bufnr ,
    mode = "n", -- NORMAL mode
    prefix = "<leader>",
    silent = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = false, -- use `nowait` when creating keymaps
  })
end

local function attach_typescript(bufnr)
  wk.register({
    c = {
      name = "LSP",
      e = { '<Cmd>TSC<CR>',                                'workspace errors (TSC)'},
      F = { '<Cmd>TypescriptFixAll<CR>',                   'fix all' },
      i = { '<Cmd>TypescriptAddMissingImports<CR>',        'import all'},
      o = { '<Cmd>TypescriptOrganizeImports<CR>',          'organize imports'},
      u = { '<Cmd>TypescriptRemoveUnused<CR>',             'remove unused' },
    }
  }, {
    buffer = bufnr ,
    mode = "n", -- NORMAL mode
    prefix = "<leader>",
    silent = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = false, -- use `nowait` when creating keymaps
  })
end

local function attach_npm(bufnr)
  wk.register({
    n = {
      name = "NPM",
      c = { '<Cmd>lua require("package-info").change_version()<CR>', 'change version' },
      d = { '<Cmd>lua require("package-info").delete()<CR>',         'delete package' },
      h = { "<Cmd>lua require('package-info').hide()<CR>",           'hide'},
      i = { '<Cmd>lua require("package-info").install()<CR>',        'install new package' },
      r = { '<Cmd>lua require("package-info").reinstall()<CR>',      'reinstall dependencies' },
      s = { '<Cmd>lua require("package-info").show()<CR>',           'show' },
      u = { '<Cmd>lua require("package-info").update()<CR>',         'update package'},
    }
  }, {
    buffer = bufnr,
    mode = "n", -- NORMAL mode
    prefix = "<leader>",
    silent = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = false, -- use `nowait` when creating keymaps
  })
end

local function attach_jest(bufnr)
  wk.register({
    j = {
      name = "Jest",
      f = { '<Cmd>lua require("neotest").run.run(vim.fn.expand("%"))<CR>', 'run current file' },
      i = { '<Cmd>lua require("neotest").summary.toggle()<CR>', 'toggle info panel' },
      j = { '<Cmd>lua require("neotest").run.run()<CR>', 'run nearest test' },
      l = { '<Cmd>lua require("neotest").run.run_last()<CR>', 'run last test' },
      o = { '<Cmd>lua require("neotest").output.open({ enter = true })<CR>', 'open test output'},
      s = { '<Cmd>lua require("neotest").run.stop()<CR>', 'stop' },
    }
  }, {
    buffer = bufnr,
    mode = "n", -- NORMAL mode
    prefix = "<leader>",
    silent = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = false, -- use `nowait` when creating keymaps
  })
end

local function attach_spectre(bufnr)
  wk.register({
    ["R"] = { "[SPECTRE] Replace all" },
    ["O"] = { "[SPECTRE] Show options" },
    ["F"] = { "[SPECTRE] Send all to quicklist" },
    ["M"] = { "[SPECTRE] Change view mode" },
  }, {
    buffer = bufnr,
    mode = "n", -- NORMAL mode
    prefix = "<leader>",
    silent = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = false, -- use `nowait` when creating keymaps
  })
end

local function attach_nvim_tree(bufnr)
  wk.register({
    ["="] = { "<Cmd>NvimTreeResize +5<CR>", "resize +5" },
    ["-"] = { "<Cmd>NvimTreeResize -5<CR>", "resize +5" },
  }, {
    buffer = bufnr,
    mode = "n",   -- NORMAL mode
    prefix = "<leader>",
    silent = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = false, -- use `nowait` when creating keymaps
  })
end

return {
  attach_markdown = attach_markdown,
  attach_typescript = attach_typescript,
  attach_npm = attach_npm,
  attach_jest = attach_jest,
  attach_spectre = attach_spectre,
  attach_nvim_tree = attach_nvim_tree,
}
