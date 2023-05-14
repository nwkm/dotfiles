return {
	"dnlhc/glance.nvim",
	config = true,
	opts = {
		hooks = {
			before_open = function(results, open, jump, method)
				if #results == 1 then
					jump(results[1]) -- argument is optional
				else
					open(results) -- argument is optional
				end
			end,
		},
	},
	cmd = { "Glance" },
	keys = {
		{ "gd", "<cmd>Glance definitions<CR>", desc = "LSP Definition" },
		{ "gr", "<cmd>Glance references<CR>", desc = "LSP References" },
		{ "gm", "<cmd>Glance implementations<CR>", desc = "LSP Implementations" },
		{ "gy", "<cmd>Glance type_definitions<CR>", desc = "LSP Type Definitions" },
	},
}