return {
	"ibhagwan/fzf-lua",
	lazy = false,
	-- optional for icon support
	dependencies = { "nvim-tree/nvim-web-devicons" },
	init = function()
		require("plugins.fzf.mappings")
	end,
	config = function()
	  require("plugins.fzf.cmds")
  	  require("plugins.fzf.config").setup()

  	  -- register fzf-lua as vim.ui.select interface
  	  require("fzf-lua").register_ui_select(function(_, items)
  	    local min_h, max_h = 0.15, 0.70
  	    local h = (#items + 4) / vim.o.lines
  	    if h < min_h then
  	      h = min_h
  	    elseif h > max_h then
  	      h = max_h
  	    end
  	    return { winopts = { height = h, width = 0.60, row = 0.40 } }
  	  end)
	end
}