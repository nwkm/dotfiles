local ok, alpha = pcall(require, "alpha")
if not ok then
	return
end

local dashboard = require("alpha.themes.dashboard")
dashboard.section.header.val = {
	"                                                     ",
	"  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
	"  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
	"  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
	"  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
	"  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
	"  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
	"                                                     ",
	"                   [ @nwkm ]                  		    ",
}
dashboard.section.buttons.val = {
	dashboard.button("e", "  New file", ":ene<CR>"),
	dashboard.button("t", "  File Explorer", ":NvimTreeToggle<CR>"),
	dashboard.button("f", "  Find File", "<Cmd>Files<CR>"),
	dashboard.button("w", "  Find Word", "<Cmd>GrepCword<CR>"),
	dashboard.button("s", "  Update plugins", ":PackerSync<CR>"),
	dashboard.button("r", "  Recent Files", "<Cmd>History<CR>"),
	dashboard.button("q", "  Quit", ":qa<CR>"),
}
dashboard.section.header.opts.hl = "String"
dashboard.section.footer.val = function()
	local total_plugins = #vim.tbl_keys(packer_plugins)
	local datetime = os.date(" %d-%m-%Y   %H:%M:%S")
	return "\n"
		.. datetime
		.. "   "
		.. total_plugins
		.. " plugins"
		.. "   v"
		.. vim.version().major
		.. "."
		.. vim.version().minor
		.. "."
		.. vim.version().patch
end
alpha.setup(dashboard.opts)
