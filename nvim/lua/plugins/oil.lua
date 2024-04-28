return {
  'stevearc/oil.nvim',
  opts = {},
  event = 'VeryLazy',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function ()
    require('oil').setup({
      default_file_explorer = true,
      float = {
        max_width = 100,
        max_height = 20
      }
    })
  end
}
