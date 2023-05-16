local ok_lspinstaller, lspinstaller = pcall(require, 'nvim-lsp-installer')
if not ok_lspinstaller then return end

local ok_lspconfig, lspconfig = pcall(require, 'lspconfig')
if not ok_lspconfig then return end

lspinstaller.setup{}

local capabilities = vim.lsp.protocol.make_client_capabilities()
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
local on_attach = function(client, bufnr)
    local opts = { noremap = true, silent = true }
    local function buf_set_keymap(...)
        vim.api.nvim_buf_set_keymap(bufnr, ...)
    end
    local function buf_set_option(...)
        vim.api.nvim_buf_set_option(bufnr, ...)
    end

    buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

    -- See `:help vim.lsp.*` for documentation on any of the below functions
    -- buf_set_keymap("n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, { noremap = true, silent = true, buffer = bufnr })
    buf_set_keymap("n", "gi", "<Cmd>lua vim.lsp.buf.implementation()<CR>", opts)
    buf_set_keymap("n", "gr", "<Cmd>lua vim.lsp.buf.references()<CR>", opts)
    buf_set_keymap("n", "gt", "<Cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
    buf_set_keymap("n", "go", "<Cmd>lua vim.diagnostic.open_float()<CR>", opts)
    buf_set_keymap("n", "gy", ":LspRef<CR>", opts)
    buf_set_keymap("n", "gd", ":LspDef<CR>", opts)
    buf_set_keymap("n", "ga", ":LspAct<CR>", opts)
    buf_set_keymap("n", "[d", "<Cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
    buf_set_keymap("n", "]d", "<Cmd>lua vim.diagnostic.goto_next()<CR>", opts)
    buf_set_keymap("n", "<leader>fo", "<Cmd>lua vim.lsp.buf.formatting()<CR>", opts)
    -- buf_set_keymap("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts)
    -- buf_set_keymap("n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)

    -- buf_set_keymap("n", "<leader>lh", "<Cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
    -- buf_set_keymap("n", "<leader>lr", "<Cmd>lua vim.lsp.buf.rename()<CR>", opts)
    -- buf_set_keymap("n", "<leader>la", "<Cmd>Telescope lsp_code_actions<CR>", opts)
    -- buf_set_keymap("n", "<leader>ls", "<Cmd>Telescope lsp_document_symbols()<CR>", opts)
    -- buf_set_keymap("n", "<leader>ld", "<Cmd>Telescope diagnostics bufnr=0<cr>", opts)

    if client.name == "tsserver" then
        client.resolved_capabilities.document_formatting = false
    elseif client.name == "eslint" then
        client.resolved_capabilities.document_formatting = true
    end
end

for _, server in ipairs(lspinstaller.get_installed_servers()) do
    local opts = {
        on_attach = on_attach,
        flags = {
            debounce_text_changes = 150,
        },
        capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)
    }
    if server.name == "sumneko_lua" then
        opts.settings = {
            Lua = {
                diagnostics = {
                    globals = { "vim" },
                },
            },
        }
    elseif server.name == "eslint" then
        opts = opts and {
            root_dir = lspconfig.util.root_pattern(".eslintrc", ".eslintrc.js", ".eslintrc.json"),
            format = {
                enable = true,
            },
            handlers = {
                -- this error shows up occasionally when formatting
                -- formatting actually works, so this will supress it
                ["window/showMessageRequest"] = function(_, result)
                    if result.message:find("ENOENT") then
                        return vim.NIL
                    end
                    return vim.lsp.handlers["window/showMessageRequest"](nil, result)
                end,
            },
        }
    end
    lspconfig[server.name].setup(opts)
end

local fn = vim.fn
local lsp = vim.lsp
local win = require('lspconfig.ui.windows')
local _default_opts = win.default_opts

win.default_opts = function(options)
  local opts = _default_opts(options)
  opts.border = 'rounded'
  return opts
end

-- Change diagnostic signs.
fn.sign_define("DiagnosticSignError", { text = "✗", texthl = "DiagnosticSignError" })
fn.sign_define("DiagnosticSignWarn", { text = "!", texthl = "DiagnosticSignWarn" })
fn.sign_define("DiagnosticSignInformation", { text = "", texthl = "DiagnosticSignInfo" })
fn.sign_define("DiagnosticSignHint", { text = "", texthl = "DiagnosticSignHint" })

-- global config for diagnostic
vim.diagnostic.config({
  underline = false,
  virtual_text = true,
  signs = false,
  severity_sort = true,
--   update_in_insert = true,
})

-- Change border of documentation hover window, See https://github.com/neovim/neovim/pull/13998.
lsp.handlers["textDocument/hover"] = lsp.with(vim.lsp.handlers.hover, {
  border = "rounded",
})
