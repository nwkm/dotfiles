return {
    {
		"neovim/nvim-lspconfig",
		event = "BufReadPre",
		dependencies = {
			"mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"hrsh7th/cmp-nvim-lsp",
		},
		servers = nil,
	},
	{
		"williamboman/mason.nvim",
		keys = {
			{ "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" },
		},
        build = ":MasonUpdate",
        cmd = "Mason",
        opts = {
            ui = {
                icons = {
                    package_installed = '✓',
                    package_pending = '➜',
                    package_uninstalled = '✗',
                },
            },
        },
	},
  	{
		"onsails/lspkind-nvim",
  		event = "InsertEnter",
		dependencies = {
			"hrsh7th/nvim-cmp",
		},
		config = function ()
			require("lspkind").init({
				mode = "symbol_text",
				preset = "default",
				symbol_map = {
					Text = "",
					Method = "",
					Function = "",
					Constructor = "",
					Field = "ﰠ",
					Variable = "",
					Class = "ﴯ",
					Interface = "",
					Module = "",
					Property = "ﰠ",
					Unit = "塞",
					Value = "",
					Enum = "",
					Keyword = "",
					Snippet = "",
					Color = "",
					File = "",
					Reference = "",
					Folder = "",
					EnumMember = "",
					Constant = "",
					Struct = "פּ",
					Event = "",
					Operator = "",
					TypeParameter = "",
					Copilot = "",
					Codeium = "",
				},
			})
		end
  	},
}
