local lspkind_ok, lspkind = pcall(require, 'lspkind')
if not lspkind_ok then return end

lspkind.init({
    -- enables text annotations (default: true)
    mode = true,

    -- enables text annotations (default: 'default')
    -- default symbol map can be either 'default' or 'codicons' for codicon preset (requires vscode-codicons font installed)
    preset = 'codicons',

    -- override preset symbols (default: {})
    symbol_map = {
        Text = '',
        Method = 'ƒ',
        Function = '',
        Constructor = '',
        Variable = '',
        Class = '',
        Interface = 'ﰮ',
        Module = '',
        Property = '',
        Unit = '',
        Value = '',
        Enum = '了',
        Keyword = '',
        Snippet = '﬌',
        Color = '',
        File = '',
        Folder = '',
        EnumMember = '',
        Constant = '',
        Struct = '',
    },
})


--local icons = {
    --Text           = ' (Text)',
    --Method         = ' (Method)',
    --Function       = ' (Function)',
    --Ctor           = ' (Constructor)',
    --Field          = ' (Field)',
    --Variable       = '襁(Variable)',
    --Class          = ' (Class)',
    --Interface      = ' (Interface)',
    --Module         = ' (Module)',
    --Property       = ' (Property)',
    --Unit           = ' (Unit)',
    --Value          = ' (Value)',
    --Enum           = '練(Enum)',
    --Keyword        = ' (Keyword)',
    --Snippet        = ' (Snippet)',
    --Color          = ' (Color)',
    --File           = ' (File)',
    --Reference      = ' (Ref)',
    --Folder         = ' (Folder)',
    --EnumMember     = ' (EnumMember)',
    --Constant       = ' (Constant)',
    --Struct         = ' (Struct)',
    --Event          = ' (Event)',
    --Operator       = ' (Operator)',
    --TypeParameter  = ' (Type Param)',
--}
    --"  (text)",
    --"  (method)",
    --"  (fun)",
    --"  (constructor)",
    --"ﰠ  (field)",
    --" (var)",
    --"ﴯ  (class)",
    --"  (interface)",
    --"  (module)",
    --"ﰠ  (property)",
    --"塞 (unit)",
    --"  (value)",
    --"  (enum)",
    --"  (keyword)",
    --"  (snippet)",
    --"  (color)",
    --"  (file)",
    --"  (reference)",
    --"  (folder)",
    --"  (enum-member)",
    --"  (constant)",
    --"פּ  (struct)",
    --"  (event)",
    --"  (operator)",
    --"   (type-param)"
    --
-- require('vim.lsp.protocol').CompletionItemKind = {
-- 	'', -- Text
-- 	'', -- Method
-- 	'', -- Function
-- 	'', -- Constructor
-- 	'', -- Field
-- 	'', -- Variable
-- 	'', -- Class
-- 	'ﰮ', -- Interface
-- 	'', -- Module
-- 	'', -- Property
-- 	'', -- Unit
-- 	'', -- Value
-- 	'了', -- Enum
-- 	'', -- Keyword
-- 	'﬌', -- Snippet
-- 	'', -- Color
-- 	'', -- File
-- 	'', -- Reference
-- 	'', -- Folder
-- 	'', -- EnumMember
-- 	'', -- Constant
-- 	'', -- Struct
-- 	'', -- Event
-- 	'ﬦ', -- Operator
-- 	'', -- TypeParameter
-- }
