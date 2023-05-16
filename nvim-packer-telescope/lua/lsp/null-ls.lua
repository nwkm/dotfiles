local ok, null_ls = pcall(require, "null-ls")
if not ok then
    return
end

-- local formatter = null_ls.builtins.formatting
-- local linter = null_ls.builtins.diagnostics
-- local action = null_ls.builtins.code_actions

-- local has_module, prettier = pcall(require, "prettier")
-- if not has_module then
-- 	return
-- end

-- local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

null_ls.setup({
    on_attach = function(_, bufnr)
        vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>ff", "", { callback = vim.lsp.buf.formatting_seq_sync })

        -- Autoformat on save
        vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = bufnr,
            callback = function()
                vim.lsp.buf.formatting_seq_sync()
            end,
        })
    end,
    sources = {
        null_ls.builtins.formatting.prettier,
        -- cargo install stylua
        -- require("null-ls").builtins.formatting.stylua,
        -- npm install eslint_d -g
        -- require("null-ls").builtins.diagnostics.eslint_d,
        -- require("null-ls").builtins.formatting.eslint_d.with({
        -- 	extra_args = { "--parser=@babel/eslint-parser" }
        -- }),
        -- npm install eslint -g
        -- require("null-ls").builtins.diagnostics.eslint,
        -- require("null-ls").builtins.formatting.eslint,
        -- npm install -g write-good
        -- require("null-ls").builtins.diagnostics.write_good,
        -- npm install -g prettier_d_slim
        -- require("null-ls").builtins.formatting.prettier_d_slim.with({
        -- 	filetypes = { "html", "javascript", "json", "typescript", "yaml", "markdown" },
        -- 	extra_args = { "--prose-wrap=always" }
        --   	}),
    },
    debug = true,
})
