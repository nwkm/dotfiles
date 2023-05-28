return {
	"mfussenegger/nvim-dap",
	keys = {
		"<Leader>da",
		"<Leader>db",
		"<Leader>dc",
		"<Leader>dh",
		"<Leader>di",
		"<Leader>do",
		"<Leader>dO",
		"<Leader>dt",
	},
	dependencies = {
		"theHamsta/nvim-dap-virtual-text",
		"rcarriga/nvim-dap-ui",
		"mxsdev/nvim-dap-vscode-js"
	},
	config = function()
		require("plugins.dap.adapters")
	end,
}