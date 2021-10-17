local lspconfig = require("lspconfig")

local u = require("utils")

--local ts_utils_settings =  {
    --debug                          = false,
    --disable_commands               = false,
    --enable_import_on_completion    = false,
    --import_on_completion_timeout   = 5000,

    --eslint_enable_code_actions     = true,
    --eslint_bin                     = "eslint",
    --eslint_args                    = {"-f", "json", "--stdin", "--stdin-filename", "$FILENAME"},
    --eslint_enable_disable_comments = true,
    --eslint_enable_diagnostics      = true,
    --eslint_diagnostics_debounce    = 250,

    --enable_formatting              = true,
    --formatter                      = "prettier",
    --formatter_args                 = {"--stdin-filepath", "$FILENAME"},
    --format_on_save                 = false,
    --no_save_after_format           = false,

    --complete_parens                = true,
    --signature_help_in_parens       = false,

    --update_imports_on_move         = false,
    --require_confirmation_on_move   = false,
--}
local ts_utils_settings = {
    -- debug = true,
    enable_import_on_completion = true,
    import_all_scan_buffers = 100,
    eslint_bin = "eslint_d",
    eslint_enable_diagnostics = true,
    eslint_opts = {
        condition = function(utils)
            return utils.root_has_file(".eslintrc.js")
        end,
        diagnostics_format = "#{m} [#{c}]",
    },
    enable_formatting = true,
    formatter = "eslint_d",
    update_imports_on_move = true,
    -- filter out dumb module warning
    filter_out_diagnostics_by_code = { 80001 },
}

local M = {}
M.setup = function(on_attach)
    lspconfig.tsserver.setup({
        on_attach = function(client, bufnr)
            client.resolved_capabilities.document_formatting = false
            client.resolved_capabilities.document_range_formatting = false

            on_attach(client, bufnr)

            local ts_utils = require("nvim-lsp-ts-utils")
            ts_utils.setup(ts_utils_settings)
            ts_utils.setup_client(client)

            u.buf_map("n", "gs", ":TSLspOrganize<CR>", nil, bufnr)
            u.buf_map("n", "gI", ":TSLspRenameFile<CR>", nil, bufnr)
            u.buf_map("n", "go", ":TSLspImportAll<CR>", nil, bufnr)
            u.buf_map("n", "qq", ":TSLspFixCurrent<CR>", nil, bufnr)

            vim.opt_local.omnifunc = "v:lua.vim.lsp.omnifunc"
        end,
        flags = {
            debounce_text_changes = 150,
        },
    })
end

return M
