local u = require('utils')

local function show_macro_recording()
    local recording_register = vim.fn.reg_recording()
    if recording_register == "" then
        return ""
    else
        return "Recording @" .. recording_register
    end
end


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
            lualine_b = { 'branch' },
            lualine_c = {
                'diff',
                {
                    'diagnostics',
                    sources = { 'nvim_diagnostic' },
                    symbols = {
                        error = nw.icons.diagnostics.Error,
                        warn = nw.icons.diagnostics.Warn .. ' ',
                        info = nw.icons.diagnostics.Info .. ' ',
                        hint = nw.icons.diagnostics.Hint .. ' ',
                    },
                },
        {
          function ()            
            local statusline = require('arrow.statusline')
            return statusline.text_for_statusline_with_icons()
          end
        },
                'filename',
                {
                    "macro-recording",
                    fmt = show_macro_recording,
                },
            },
            lualine_x = {
                -- {
                --     function() return require("noice").api.status.command.get() end,
                --     cond = function() return package.loaded["noice"] and require("noice").api.status.command.has() end,
                --     color = u.fg("Statement"),
                -- },
                  -- stylua: ignore
                -- {
                --     function() return require("noice").api.status.mode.get() end,
                --     cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
                --     color = u.fg("Constant"),
                -- },
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
    }
}
