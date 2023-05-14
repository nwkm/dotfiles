return {
	"mfussenegger/nvim-dap",
	keys = {
		"<Leader>da",
		"<Leader>db",
		"<Leader>dc",
		"<Leader>dd",
		"<Leader>dh",
		"<Leader>di",
		"<Leader>do",
		"<Leader>dO",
		"<Leader>dt",
	},
	dependencies = {
		"theHamsta/nvim-dap-virtual-text",
		"rcarriga/nvim-dap-ui",
	},
	config = function()
		require("plugins.dap.dap-config")
	end,
}