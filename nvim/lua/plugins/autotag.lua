local filetypes = {
  'html', 'javascript', 'javascriptreact', 'typescriptreact', 'svelte', 'vue'
}

require('nvim-ts-autotag').setup({
  filetypes = filetypes
})
