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
  { "onsails/lspkind-nvim" },
 --  {
	-- 	"jose-elias-alvarez/null-ls.nvim",
	-- 	event = "BufNewFile",
	-- 	dependencies = { "mason.nvim" },
	-- },
    -- { "jose-elias-alvarez/typescript.nvim" },
	-- {
	-- 	"jay-babu/mason-null-ls.nvim",
	-- 	event = { "BufReadPre", "BufNewFile" },
	-- 	dependencies = {
	-- 		"williamboman/mason.nvim",
	-- 		"jose-elias-alvarez/null-ls.nvim",
	-- 	},
	-- 	config = function()
 --            require("mason-null-ls").setup({
 --                ensure_installed = {
 --                  -- Opt to list sources here, when available in mason.
 --                },
 --                automatic_installation = false,
 --                automatic_setup = true, -- Recommended, but optional
 --                handlers = {},
 --            })
 --            require("null-ls").setup({
 --                -- sources = {
 --                --   require("null-ls").builtins.diagnostics.codespell.with({
 --                --     filetypes = { "markdown", "text" },
 --                --   }),
 --                -- },
 --            })
	-- 	end,
	-- },
}
