return {
	{
		'lewis6991/gitsigns.nvim',
		ft = 'gitcommit',
		init = function()
			-- load gitsigns only when a git file is opened
			vim.api.nvim_create_autocmd({ 'BufRead' }, {
				group = vim.api.nvim_create_augroup('GitSignsLazyLoad', { clear = true }),
				callback = function()
					vim.fn.system('git -C ' .. '"' .. vim.fn.expand('%:p:h').. '"' .. ' rev-parse')
					if vim.v.shell_error == 0 then
						vim.api.nvim_del_augroup_by_name 'GitSignsLazyLoad'
						vim.schedule(function()
							require('lazy').load { plugins = { 'gitsigns.nvim' } }
						end)
					end
				end,
			})
		end,
		opts = require("plugins.git.git-signs"),
		config = function(_, opts)
			local gitsigns = require('gitsigns')
			gitsigns.setup(opts)
			-- scrollbar integration
			require('scrollbar.handlers.gitsigns').setup()
		end,
	},
	{
		"sindrets/diffview.nvim",
		lazy = true,
		enabled = true,
		event = "BufRead",
		config = function()
			require("plugins.git.git-diffview")
		end,
	},
	{
		"ThePrimeagen/git-worktree.nvim",
		keys = {
			"<Leader>gwc",
			"<Leader>gww",
		},
		config = function()
			require("plugins.git.git-worktree")
		end,
	},
	{
		"akinsho/git-conflict.nvim",
		lazy = false,
		config = function()
			require("plugins.git.git-conflict")
		end,
	},
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim"
    },
    lazy = false,
    config = true,
  },
	{
		"kdheepak/lazygit.nvim",
		cmd = {
			"LazyGit",
			"LazyGitCurrentFile",
			"LazyGitFilterCurrentFile",
			"LazyGitFilter",
		},
		config = function()
			vim.g.lazygit_floating_window_scaling_factor = 1
		end,
	}
}
