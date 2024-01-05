return {
	"j-hui/fidget.nvim",
	event = 'LspAttach',
	config = function()
		local status_ok, fidget = pcall(require, "fidget")
		if not status_ok then
			return
		end

		fidget.setup({
			integration = {
				["nvim-tree"] = {
					enable = false
				},
			},
		})
	end
}
