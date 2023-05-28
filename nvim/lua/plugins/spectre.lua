return {
	"nvim-pack/nvim-spectre",
	opts = {
		default = {
			find = {
				--pick one of item in find_engine
				cmd = "rg",
				options = {"--smart-case"}
			},
			replace={
				--pick one of item in replace_engine
				cmd = "sed"
			}
		},
		highlight          = {
			-- headers = "Comment",
			-- ui = "String",
			-- filename = "Keyword",
			-- filedirectory = "Comment",
			-- border = "Comment",
			search = "Search",
			replace = "IncSearch"
		},
		mapping = {
			['run_replace'] = {
				map = "<leader>R",
				cmd = "<cmd>lua require('spectre.actions').run_replace()<CR>",
				-- desc = "[SPECTRE] Replace all"
			},
			['send_to_qf'] = {
				map = "<leader>F",
				cmd = "<cmd>lua require('spectre.actions').send_to_qf()<CR>",
				-- desc = "[SPECTRE] Send all item to quickfix"
			},
			['show_option_menu'] = {
				map = "<leader>O",
				cmd = "<cmd>lua require('spectre').show_options()<CR>",
				-- desc = "[SPECTRE] Show option"
			},
			['change_view_mode'] = {
				map = "<leader>M",
				cmd = "<cmd>lua require('spectre').change_view()<CR>",
				-- desc = "[SPECTRE] Change view mode"
			},
		}
	}
}