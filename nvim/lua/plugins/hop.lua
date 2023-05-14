return {
	'phaazon/hop.nvim',
	branch = 'v2',
	event = 'VeryLazy',
	keys = {
		{ "s", "<Cmd>HopWord<CR>", desc = "Search" },
	},
	config = function()
		require("hop").setup { keys = 'etovxqpdygfblzhckisuran' }
	end
}