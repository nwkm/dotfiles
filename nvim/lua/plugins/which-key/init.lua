return {
    'folke/which-key.nvim',
    keys = {
        "<leader>",
        '"',
        "'",
        "`",
    },
    config = function()
        require("plugins.which-key.wk-config")
    end,
}
