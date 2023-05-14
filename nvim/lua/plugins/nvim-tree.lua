return {
    'nvim-tree/nvim-tree.lua',
    dependencies = 'nvim-tree/nvim-web-devicons',
    cmd = {
        "NvimTreeOpen",
        "NvimTreeClose",
        "NvimTreeToggle",
        "NvimTreeFindFile",
        "NvimTreeFindFileToggle",
    },
    keys = {
        -- { "<C-e>", "<cmd>lua require('nvim-tree.api').tree.toggle()<CR>", desc = "NvimTree" },
        { "<Leader>e", ":NvimTreeToggle<CR>", desc = "NvimTreeToggle" },
    },
    opts = {
        disable_netrw = true,
        hijack_netrw = true,
        diagnostics = {
            enable = true,
            show_on_dirs = true,
            icons = {
                hint = nw.icons.diagnostics.Hint,
                info = nw.icons.diagnostics.Info,
                warning = nw.icons.diagnostics.Warn,
                error = nw.icons.diagnostics.Error,
            },
        },
        renderer = {
            root_folder_modifier = ':t',
            icons = {
                glyphs = {
                    git = {
                        unstaged = '✗',
                        staged = '✓',
                        unmerged = '',
                        renamed = '➜',
                        untracked = '★',
                        deleted = '',
                        ignored = '◌',
                    },
                },
            },
        },
        filters = {
            custom = { '^.git$' },
        },
        update_focused_file = {
            enable = true,
            update_cwd = true
        }
    },
}
