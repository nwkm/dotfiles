return {
	"j-hui/fidget.nvim",
	event = 'LspAttach',
  tag = 'legacy',
	config = function()
		local status_ok, fidget = pcall(require, "fidget")
		if not status_ok then
			return
		end

		fidget.setup({})
	end
}
