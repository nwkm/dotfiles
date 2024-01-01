return {
  "alexghergh/nvim-tmux-navigation",
  event = "VeryLazy",
  cmd = {
    'NvimTmuxNavigateLef',
    'NvimTmuxNavigateRight',
    'NvimTmuxNavigateUp',
    'NvimTmuxNavigateDown',
  },
  config = function()
    require'nvim-tmux-navigation'.setup {
      disable_when_zoomed = true, -- defaults to false
      keybindings = {
        left = "<C-h>",
        down = "<C-j>",
        up = "<C-k>",
        right = "<C-l>",
      }
    }
  end
}
