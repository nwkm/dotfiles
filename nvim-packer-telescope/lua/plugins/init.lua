-- install packer automatically on new system
-- https://github.com/wbthomason/packer.nvim#bootstrapping
local fn = vim.fn

local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
local compile_path = fn.stdpath "data" .. "/plugin/packer_compiled.lua"

if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
end

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, 'packer')
if not status_ok then
  return
end

-- sync plugins on write/save
vim.api.nvim_create_augroup('SyncPackerPlugins', {})
vim.api.nvim_create_autocmd(
  'BufWritePost',
  { command = 'source <afile> | PackerSync', pattern = 'plugins.lua', group = 'SyncPackerPlugins' }
)

local commits = require('plugins/commits')

-- Plugins via Packer
return require('packer').startup {
    function(use)
        use {
            'lewis6991/impatient.nvim',
            config = [[ require('impatient') ]]
        }
        use 'wbthomason/packer.nvim'
        use 'tpope/vim-fugitive'
        use 'tpope/vim-repeat'
        use 'tpope/vim-surround'
        use {
            'nvim-treesitter/nvim-treesitter',
            requires = {
                { 'lewis6991/spellsitter.nvim' },
                { 'mfussenegger/nvim-ts-hint-textobject' },
                { 'nvim-treesitter/playground' },
                { 'nvim-treesitter/nvim-treesitter-textobjects' },
                { 'nvim-treesitter/nvim-treesitter-refactor' },
            }, run = ':TSUpdate',
            config = [[ require('plugins/treesitter') ]]
        }
        use 'nvim-lua/plenary.nvim'
        use 'kyazdani42/nvim-web-devicons'
        use {
            'lukas-reineke/indent-blankline.nvim',
            config = [[ require('plugins/indentation') ]]
        }

        -- Lsp
        use {
            'neovim/nvim-lspconfig',
            requires = {
                'williamboman/nvim-lsp-installer',
                {
                    'j-hui/fidget.nvim',
                    config = function()
                        require("fidget").setup()
                    end,
                },
            },
            config = [[ require('lsp') ]]
        }
        use { -- Use Neovim as a language server to inject LSP diagnostics, code actions, and more via Lua.
            'jose-elias-alvarez/null-ls.nvim',
            commit = commits.null_ls_nvim,
            config = [[ require('lsp/null-ls') ]]
        }
        use "jose-elias-alvarez/nvim-lsp-ts-utils"
        use { -- A completion plugin for neovim coded in Lua.
            'hrsh7th/nvim-cmp',
            commit = commits.nvim_cmp,
            requires = {
                { -- Snippet Engine for Neovim written in Lua.
                    'L3MON4D3/LuaSnip',
                    commit = commits.LuaSnip,
                    requires = {"rafamadriz/friendly-snippets", commit=commits.friendly_snippets},  -- Snippets collection for a set of different programming languages for faster development.
                },
                {"hrsh7th/cmp-nvim-lsp", commit=commits.cmp_nvim_lsp},   -- nvim-cmp source for neovim builtin LSP client
                {"hrsh7th/cmp-buffer", commit=commits.cmp_buffer},       -- nvim-cmp source for buffer words.
                {"hrsh7th/cmp-path", commit=commits.cmp_path},           -- nvim-cmp source for filesystem paths.
                {"hrsh7th/cmp-nvim-lua", ft = 'lua', commit=commits.cmp_nvim_lua}, -- nvim-cmp source for nvim lua
                {"hrsh7th/cmp-nvim-lsp-signature-help", commit=commits.cmp_nvim_lsp_signature_help}, -- nvim-cmp source for displaying function signatures with the current parameter emphasized:
                {"saadparwaiz1/cmp_luasnip", commit=commits.cmp_luasnip},-- luasnip completion source for nvim-cmp
            },
            config = [[
                require('plugins/cmp')
                require('plugins/snip')
            ]]
        }
        -- Vscode-like pictograms for neovim lsp completion items Topics
        use {
            'onsails/lspkind-nvim',
            commit = commits.lspkind_nvim,
            config = [[ require('plugins/lspkind') ]]
        }

        -- 🔭telescope
        --  use {
        -- 	'nvim-telescope/telescope.nvim',
        -- 	requires = { 'nvim-lua/plenary.nvim' },
        -- 	config = function()
        -- 		require("plugins.telescope")
        -- 	end
        --   }
        --   use "nvim-telescope/telescope-file-browser.nvim"
        --   use "nvim-telescope/telescope-ui-select.nvim"
        --   use "dhruvmanila/telescope-bookmarks.nvim"
        --   use "nvim-telescope/telescope-github.nvim"
        --   use { "nvim-telescope/telescope-fzf-native.nvim", run = "make" }
        --   use "LinArcX/telescope-command-palette.nvim"
        use {
            'ibhagwan/fzf-lua',
            config = [[ require('plugins/fzf') ]]
        }
        -- Motion
        use {
            'phaazon/hop.nvim',
            as = 'hop',
            config = function()
                require('hop').setup({ keys = 'etovxqpdygfblzhckisuran' })
            end,
        }
        use {
            'ahmedkhalf/project.nvim',
            requires = {'neovim/nvim-lspconfig'},
            config = function()
                require('project_nvim').setup()
            end
        }
        use {
            'windwp/nvim-autopairs',
            config = "require('plugins.autopairs')",
        }
        use {
            'nvim-lualine/lualine.nvim',
            requires = { 'kyazdani42/nvim-web-devicons', opt = true },
            config = [[ require('plugins/lualine') ]]
        }
        use {
            'romgrk/barbar.nvim',
            requires = {'kyazdani42/nvim-web-devicons'},
            config = function()
                require "plugins.barbar"
            end
        }
        use {
            "lewis6991/gitsigns.nvim",
            requires = { "nvim-lua/plenary.nvim" },
            config = function()
                require('gitsigns').setup()
            end
        }
        use {
            'rhysd/git-messenger.vim',
            config = function()
                require("plugins.messenger")
            end
        }
        use {
            'numToStr/Comment.nvim',
            config = function()
                require("plugins.comment")
            end
        }
        -- floating terminal
        use({
            'voldikss/vim-floaterm',
            opt = true,
            event = 'BufWinEnter',
            config = function()
                require('plugins.terminal')
            end,
        })
        -- file explorer
        use({
            'kyazdani42/nvim-tree.lua',
            config = function()
                require('plugins.nvimtree')
            end,
            cmd = {
                'NvimTreeClipboard',
                'NvimTreeClose',
                'NvimTreeFindFile',
                'NvimTreeOpen',
                'NvimTreeRefresh',
                'NvimTreeToggle',
            },
            event = 'VimEnter',
        })
        -- dashboard
        use({
            "goolord/alpha-nvim",
            requires = { "kyazdani42/nvim-web-devicons" },
            config = function()
                require("plugins.alpha")
            end,
        })
        -- theme
        use({
            'Shatur/neovim-ayu',
            config = function()
                local ayu = require('ayu')
                ayu.setup({
                    mirage = true,
                    overrides = {},
                })
                ayu.colorscheme()
            end
        })
        --   use({
        -- 	"folke/which-key.nvim",
        -- 	opt = true,
        -- 	event = "VimEnter",
        -- 	config = function()
        -- 		require("which-key").setup()
        -- 	end,
        -- })

        -- setup config after cloning packer
        if PACKER_BOOTSTRAP then
            require("packer").sync()
        end
    end,
    config = {
        display = {
            open_fn = require('packer.util').float,
        }
    }
}
