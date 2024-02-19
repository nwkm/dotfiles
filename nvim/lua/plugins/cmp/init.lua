return {
    "hrsh7th/nvim-cmp",
    dependencies = {
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-nvim-lua",
        "hrsh7th/cmp-cmdline",
	    "hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
        "saadparwaiz1/cmp_luasnip",
        {
            "L3MON4D3/LuaSnip",
            build = "make install_jsregexp",
            version = "v1.*",
        },
        "rafamadriz/friendly-snippets",
    },
    event = "InsertEnter",
    config = function()
		require("plugins.cmp.cmp-config")
    end,
}
