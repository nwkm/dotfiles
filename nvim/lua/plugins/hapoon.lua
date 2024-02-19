return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	requires = { "nvim-lua/plenary.nvim" },
	keys = {
		{
			"<leader>h",
			mode = { "n" },
			function()
				local harpoon = require("harpoon")
				harpoon:setup({
					settings = {
						save_on_toggle = true,
						sync_on_ui_close = true,
					},
				})
				harpoon:list():append()
			end,
			desc = "Add file to harpoon",
		},
		{
			"<C-e>",
			mode = { "n" },
			function()
				local harpoon = require("harpoon")
				harpoon:setup({
					settings = {
						save_on_toggle = true,
						sync_on_ui_close = true,
					},
				})
				harpoon.ui:toggle_quick_menu(harpoon:list())
			end,
			desc = "Toggle harpoon menu",
		},
		{
			"<C-b>",
			mode = { "n" },
			function()
				local harpoon = require("harpoon")
				harpoon:setup({
					settings = {
						save_on_toggle = true,
						sync_on_ui_close = true,
					},
				})
				harpoon:list():select(1)
			end,
			desc = "Select harpoon item 1",
		},
		{
			"<C-i>",
			mode = { "n" },
			function()
				local harpoon = require("harpoon")
				harpoon:setup({
					settings = {
						save_on_toggle = true,
						sync_on_ui_close = true,
					},
				})
				harpoon:list():select(2)
			end,
			desc = "Select harpoon item 2",
		},
		{
			"<C-g>",
			mode = { "n" },
			function()
				local harpoon = require("harpoon")
				harpoon:setup({
					settings = {
						save_on_toggle = true,
						sync_on_ui_close = true,
					},
				})
				harpoon:list():select(3)
			end,
			desc = "Select harpoon item 3",
		},
		{
			"<C-s>",
			mode = { "n" },
			function()
				local harpoon = require("harpoon")
				harpoon:setup({
					settings = {
						save_on_toggle = true,
						sync_on_ui_close = true,
					},
				})
				harpoon:list():select(4)
			end,
			desc = "Select harpoon item 4",
		},
	},
	config = function()
		local harpoon = require("harpoon")

		harpoon:setup({
			settings = {
				save_on_toggle = true,
				sync_on_ui_close = true,
			},
		})
	end,
}
