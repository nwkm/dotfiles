vim.g.kommentary_create_default_mappings = false

--vim.api.nvim_set_keymap("n", "gcc", "<Plug>kommentary_line_default", {})
vim.api.nvim_set_keymap("n", "<C-_>", "<Plug>kommentary_line_default", {})
vim.api.nvim_set_keymap("n", "gc", "<Plug>kommentary_motion_default", {})
--vim.api.nvim_set_keymap("v", "gc", "<Plug>kommentary_visual_default<C-c>", {})
vim.api.nvim_set_keymap("v", "<C-_>", "<Plug>kommentary_visual_default<C-c>", {})

require('kommentary.config').configure_language({"javascript", "typescript"}, {
    ignore_whitespace = true,
    use_consistent_indentation = true,
    prefer_single_line_comments = true,
})

