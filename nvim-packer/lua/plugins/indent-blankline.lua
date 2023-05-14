if not pcall(require, 'indent_blankline') then
  return
end

local context_patterns = {
    "class",
    "function",
    "method",
    "^if",
    "while",
    "for",
    "with",
    "func_literal",
    "block",
    "try",
    "except",
    "argument_list",
    "object",
    "dictionary"
}

-- vim.api.nvim_set_keymap('', '<leader>"', '<Esc>:IndentBlanklineToggle<CR>',
--vim.api.nvim_set_keymap('', '<leader>"',
  --'<cmd>lua require("indent_blankline.commands").toggle("<bang>" == "!")<CR>',
  --{ noremap = true, silent = true })

require'indent_blankline'.setup {
    char = '¦',
    enabled = true,
    strict_tabs = true,
    show_current_context = true,
    char_highlight = 'LineNr',
    buftype_exclude = {'terminal', 'nofile'},
    filetype_exclude = {'help', 'packer'},
    space_char_blankline = ' ',
    context_patterns = context_patterns
}
