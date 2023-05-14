local u = require('utils')

return {
    'nvim-lualine/lualine.nvim',
    dependencies = 'nvim-tree/nvim-web-devicons',
    event = {
        'BufReadPost',
        'BufNewFile',
    },
    opts = {
        options = {
            theme = 'auto',
            disabled_filetypes = { 'mason', 'dashboard' },
        },
        tabline = {
            lualine_a = {
                "buffers"
            },
            lualine_b = {},
            lualine_c = {},
            lualine_x = {},
            lualine_y = {},
            lualine_z = {"tabs"}
        },
        sections = {
            lualine_a = { 'mode' },
            lualine_b = {
                'branch',
                'diff',
            },
            lualine_c = {
                {
                    'diagnostics',
                    sources = { 'nvim_lsp', 'nvim_diagnostic' },
                    symbols = {
                        error = nw.icons.diagnostics.Error .. ' ',
                        warn = nw.icons.diagnostics.Warn .. ' ',
                        info = nw.icons.diagnostics.Info .. ' ',
                        hint = nw.icons.diagnostics.Hint .. ' ',
                    },
                },
                'filename',
            },
            lualine_x = {
                {
                    function() return require("noice").api.status.command.get() end,
                    cond = function() return package.loaded["noice"] and require("noice").api.status.command.has() end,
                    color = u.fg("Statement"),
                },
                  -- stylua: ignore
                {
                    function() return require("noice").api.status.mode.get() end,
                    cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
                    color = u.fg("Constant"),
                },
                  -- stylua: ignore
                {
                    function() return "  " .. require("dap").status() end,
                    cond = function () return package.loaded["dap"] and require("dap").status() ~= "" end,
                    color = u.fg("Debug"),
                },
                { require("lazy.status").updates, cond = require("lazy.status").has_updates, color = u.fg("Special") },
                'fileformat',
                'filetype',
            },
            lualine_y = { 'progress' },
            lualine_z = { 'location' },
        },
        extensions = {
            'man',
            'nvim-tree',
            'toggleterm'
        }
    },
}
