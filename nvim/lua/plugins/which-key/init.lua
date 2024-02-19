return {
    'folke/which-key.nvim',
    event = "VeryLazy",
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
