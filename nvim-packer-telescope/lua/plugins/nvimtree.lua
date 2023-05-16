local g = vim.g
local icons = require('config.icons')
local u = require('config.utils')
local augroup_name = 'NvimNvimTree'
local group = vim.api.nvim_create_augroup(augroup_name, { clear = true })

-- set up args
local args = {
  respect_buf_cwd = true,

  diagnostics = {
    enable = true,
  },
  ignore_ft_on_setup = {
    'startify',
    'dashboard',
    'alpha',
  },
  update_focused_file = {
    enable = true,
  },
  view = {
    width = 35,
    mappings = {
      custom_only = false,
      list = {
        { key = "<C-n>",                        action = "tabnew" },
        { key = "u",                            action = "dir_up" },
        { key = "<C-t>",                        action = "close" },
      }
    },
  },
  git = {
    ignore = true,
  },
  renderer = {
    highlight_git = true,
    icons = {
      glyphs = {
        default = '',
        symlink = icons.symlink,
        git = icons.git,
        folder = icons.folder,
      }
    },
    -- special_files = { "Cargo.toml", "Makefile", "README.md", "readme.md" },
  }
}

vim.api.nvim_create_autocmd('BufEnter', {
  command = [[if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif]],
  group = group,
  nested = true,
})

require('nvim-tree').setup(args)

local nmap = require('config.utils').nmap

nmap('<C-t>', ':NvimTreeToggle<CR>')
nmap('<Leader>r', ':NvimTreeRefresh<CR>')
