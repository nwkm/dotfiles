if not require("plugins.bootstrap") then
  return
end

local packer = require'packer'
return packer.startup({
  function(use)

    -- TODO: causes issies with lspconfig
    -- speed up 'require', must be the first plugin
    -- use { "lewis6991/impatient.nvim",
      -- config = 'pcall(require, "impatient")' }

    -- Packer can manage itself as an optional plugin
    use { 'wbthomason/packer.nvim', opt = true }

    -- Analyze startuptime
    use { 'tweekmonster/startuptime.vim', cmd = 'StartupTime' }

    -- tpope's plugins that should be part of vim
    use { 'tpope/vim-surround' }
    use { 'tpope/vim-repeat' }

    -- needs no introduction
    use { 'tpope/vim-fugitive',
        config = "require('plugins.fugitive')",}
        -- event = "VimEnter" }

    use {
        'windwp/nvim-autopairs',
        config = "require('plugins.autopairs')",
    }
    use {
        'christoomey/vim-tmux-runner',
        config = "require('plugins.vtr')",
    }
    -- "gc" to comment visual regions/lines
    use { 'b3nj5m1n/kommentary',
        config = "require('plugins.kommentary')",
        -- uncomment for lazy loading
        -- causes delay with visual mapping
        -- keys = {'gcc', 'gc'}
    }
    --[[ use {
      'numToStr/Comment.nvim',
      config = function()
        require('Comment').setup()
      end
    } ]]
    use { 
      'karb94/neoscroll.nvim',
      config = function()
        require('neoscroll').setup()
      end
    }

    -- :DiffViewOpen :DiffViewClose
    use { 'sindrets/diffview.nvim', opt = true,
        cmd = { 'DiffviewOpen', 'DiffviewClose' }}

    -- plenary is required by gitsigns and telescope
    -- lazy load so gitsigns doesn't abuse our startup time
    use { 'nvim-lua/plenary.nvim' }

    -- Add git related info in the signs columns and popups
    use { 'lewis6991/gitsigns.nvim',
        requires = { 'nvim-lua/plenary.nvim' },
        config = "require('plugins.gitsigns')",
        after = "plenary.nvim" }

    -- Add indentation guides even on blank lines
    use { 'lukas-reineke/indent-blankline.nvim', --branch="lua",
     event = "BufRead",
     config = "require('plugins.indent-blankline')",
     cmd = { 'IndentBlanklineToggle' } }

    -- Neoterm (REPLs)
    use { 'kassio/neoterm',
        config = "require('plugins.neoterm')",
        keys = {'gxx', 'gx'},
        cmd = { 'T' },
    }

    -- yank over ssh with ':OCSYank' or ':OSCYankReg +'
    use { 'ojroques/vim-oscyank',
        config = function()
            vim.g.oscyank_term = 'tmux'
        end,
        cmd = { 'OSCYank', 'OSCYankReg' },
    }
    use { 'christoomey/vim-tmux-navigator' }

    -- Autocompletion & snippets
    use { 'L3MON4D3/LuaSnip',
      config = 'require("plugins.luasnip")',
      event = 'InsertEnter' }

    use { 'hrsh7th/nvim-cmp',
        requires = {
          { 'hrsh7th/cmp-path', after = 'nvim-cmp' },
          { 'hrsh7th/cmp-buffer', after = 'nvim-cmp' },
          { 'hrsh7th/cmp-nvim-lsp', after = 'nvim-cmp' },
          { 'saadparwaiz1/cmp_luasnip', after = 'nvim-cmp' },
        },
        config = "require('plugins.cmp')",
        -- event = "InsertEnter", }
        after = 'LuaSnip', }

    -- nvim-treesitter
    -- verify a compiler exists before installing
    if require'utils'.have_compiler() then
        use { 'nvim-treesitter/nvim-treesitter',
            config = "require('plugins.treesitter')",
            run = ':TSUpdate',
            event = 'BufRead' }
        use { 'nvim-treesitter/nvim-treesitter-textobjects',
            after = { 'nvim-treesitter' } }
        -- debuging treesitter
        use { 'nvim-treesitter/playground',
            after = { 'nvim-treesitter' },
            cmd = { 'TSPlaygroundToggle' },
            opt = true }
    end

    -- optional for fzf-lua, telescope, nvim-tree, feline
    use { 'kyazdani42/nvim-web-devicons', event = 'VimEnter' }

    -- nvim-tree
    use {
        'kyazdani42/nvim-tree.lua',
        requires = { 'kyazdani42/nvim-web-devicons' },
        config = "require('plugins.nvim-tree')",
        cmd = { 'NvimTreeToggle', 'NvimTreeFindFile' },
        opt = true,
    }

    use { 'ibhagwan/fzf-lua',
        requires = {
          { 'vijaymarupudi/nvim-fzf' },
          { 'kyazdani42/nvim-web-devicons' },
        },
        setup = "require('plugins.fzf-lua.mappings')",
        config = "require('plugins.fzf-lua')",
        opt = true,
    }

    -- better quickfix
    use {
        'kevinhwang91/nvim-bqf',
        config = "require'plugins.bqf'",
        ft = { 'qf' }
    }

    -- LSP
    use { 'neovim/nvim-lspconfig' }
    use {
      'mfussenegger/nvim-dap',
      config = "require('debuggers').post()",
      requires = {
        { 'mfussenegger/nvim-dap-python' },
        { 'rcarriga/nvim-dap-ui' },
      },
      opt = true
    }
    use { 'jose-elias-alvarez/nvim-lsp-ts-utils' }
    use { 'jose-elias-alvarez/null-ls.nvim' }
    use { 
      'windwp/nvim-ts-autotag',
      event = "InsertEnter",
      config = function()
         require("nvim-ts-autotag").setup()
      end,
      ft = { 'typescript', 'typescriptreact' }
    } -- automatically close jsx tags
    use({ 'JoosepAlviste/nvim-ts-context-commentstring', ft = { 'typescript', 'typescriptreact' } }) -- makes jsx comments actually work

    -- Colorizer
    use { 'patstockwell/vim-monokai-tasty' }
    use { 'norcalli/nvim-colorizer.lua',
        config = function() require'colorizer'.setup() end,
        cmd = {'ColorizerAttachToBuffer', 'ColorizerDetachFromBuffer' },
        opt = true }


    use { 'previm/previm',
        config = function()
            vim.g.previm_open_cmd = 'firefox'
            vim.g.previm_enable_realtime = 0
        end,
        opt = true, cmd = { 'PrevimOpen' } }

    -- key bindings cheatsheet
    use { 'folke/which-key.nvim',
        config = "require('plugins.which_key')",
        event = "VimEnter" }
    use { 'vim-airline/vim-airline' }

  end,
  config = {
    display = {
      open_fn = require('packer.util').float,
    }
  }
})
