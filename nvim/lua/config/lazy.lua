local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
	"git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
  
local opts = {
	defaults = {
		lazy = true
	},
    ui = {
        custom_keys = { false },
		border = nw.ui.float.border,
    },
    install = {
        colorscheme = { 'tokyonight' }
    },
    performance = {
        rtp = {
            disabled_plugins = {
                'gzip',
                'netrwPlugin',
                'tarPlugin',
                'tohtml',
                'tutor',
                'zipPlugin',
                'rplugin',
                'editorconfig',
                'matchparen',
                'matchit'
            }
        }
    },
    spec = {
        { import = "plugins" }
    }
}

-- Load the plugins and options
require('lazy').setup(opts)