return {
  'windwp/nvim-ts-autotag',
  event = { 'InsertEnter' },
  lazy = false,
  config = function()
    local autotag = require('nvim-ts-autotag')
    autotag.setup({})
  end
}
