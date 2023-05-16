local ok, indentation = pcall(require, 'indent_blankline')
if not ok then
  return
end

local context_patterns = {
    "class",
    "function",
    "arrow_function",
    "method",
    "^if",
    "^while",
    "^for",
    "with",
    "func_literal",
    "block",
    "try",
    "except",
    "argument_list",
    "^object",
    "dictionary",
    "typedef",
    "return",
    "jsx_element",
    "jsx_self_closing_element",
}

indentation.setup {
    char = '¦',
    enabled = true,
    -- strict_tabs = true,
    show_current_context = true,
    -- show_current_context_start = true,
    show_first_indent_level = false,
    show_trailing_blankline_indent = false,
    char_highlight = 'LineNr',
    buftype_exclude = {'terminal', 'nofile'},
    filetype_exclude = {'help', 'packer'},
    context_patterns = context_patterns,
}
