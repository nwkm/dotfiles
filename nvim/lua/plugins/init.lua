return {
    -- nvim-surround
    {
        'kylechui/nvim-surround',
        version = "*", -- Use for stability; omit to use `main` branch for the latest features
        config = true
    },

    -- Comment.nvim
    {
        'numToStr/Comment.nvim',
        event = {
            'BufReadPost',
            'BufNewFile'
        },
        opts = {
            toggler = {
                line = '<C-/>',
            },
            opleader = {
                line = '<C-/>',
            },
        },
        config = true
    },

    -- bufdelete.nvim
    {
        'famiu/bufdelete.nvim',
        cmd = {
            'Bdelete',
            'Bwipeout'
        }
    },

    -- hlargs.nvim
    {
        'm-demare/hlargs.nvim',
        dependencies = 'nvim-treesitter/nvim-treesitter',
        ft = {
            'c',
            'cpp',
            'cs',
            'go',
            'java',
            'js',
            'jsx',
            'ts',
            'tsx',
            'jl',
            'lua',
            'nix',
            'php',
            'py',
            'r',
            'R',
            'rb',
            'vim',
            'zig',
            'rs'
        },
        config = true
    },

    -- nvim-hlslens
    {
        'kevinhwang91/nvim-hlslens',
        keys = {
            'n',
            'N',
            '*',
            '#'
        },
        dependencies = 'romainl/vim-cool',
        config = true
    },

    -- numb.nvim
    {
        'nacro90/numb.nvim',
        event = 'CmdlineEnter',
        config = true
    },

    -- symbols-outline.nvim
    {
        'simrat39/symbols-outline.nvim',
        cmd = 'SymbolsOutline',
        config = true
    }
}
