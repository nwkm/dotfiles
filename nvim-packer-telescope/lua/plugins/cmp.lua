-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

local cmp_imported_ok, cmp = pcall(require, 'cmp')
if not cmp_imported_ok then return end

local luasnip_imported_ok, luasnip = pcall(require, 'luasnip')
if not luasnip_imported_ok then return end

-- for completion window width
local ELLIPSIS_CHAR = '…'
local MAX_LABEL_WIDTH = 35

cmp.setup({

    -- -- Disabling completion in certain contexts, such as comments
    -- enabled = function()
    -- 	-- disable completion in comments
    -- 	local context = require 'cmp.config.context'
    -- 	-- keep command mode completion enabled when cursor is in a comment
    -- 	if vim.api.nvim_get_mode().mode == 'c' then
    -- 		return true
    -- 	else
    -- 		return not context.in_treesitter_capture("comment")
    -- 			and not context.in_syntax_group("Comment")
    -- 	end
    -- end,

    completion = {
        -- completeopt = 'menu,menuone,noinsert',
    },

    snippet = {
        expand = function(args) luasnip.lsp_expand(args.body) end,
    },

    formatting = {
        format = function(entry, vim_item)
            -- fancy icons and a name of kind
            vim_item.kind = require("lspkind").presets.default[vim_item.kind]

            -- limit completion width
            local label = vim_item.abbr
            local truncated_label = vim.fn.strcharpart(label, 0, MAX_LABEL_WIDTH)
            if truncated_label ~= label then
                vim_item.abbr = truncated_label .. ELLIPSIS_CHAR
            end

            -- set a name for each source
            vim_item.menu = ({
                buffer = "[Buff]",
                nvim_lsp = "[LSP]",
                luasnip = "[LuaSnip]",
                nvim_lua = "[Lua]",
                latex_symbols = "[Latex]",
            })[entry.source.name]
            return vim_item
        end,
    },

    sources = {
        {name = 'nvim_lsp'},
        {name = 'nvim_lsp_signature_help' },
        {name = 'nvim_lua'},
        {name = 'path'},
        {name = 'luasnip'},
        {name = 'buffer', keyword_length = 1},
        -- {name = 'calc'},
    },

    window = {
        documentation = {
            border = {"┌", "─", "┐", "│", "┘", "─", "└", "│"},
        },
        completion = {
            border = {"┌", "─", "┐", "│", "┘", "─", "└", "│"},
        }
    },

    experimental = {
        -- ghost_text = true,
    },

})

-- -- Require function for tab to work with LUA-SNIP
-- local has_words_before = function()
--     local line, col = unpack(vim.api.nvim_win_get_cursor(0))
--     return col ~= 0 and
-- 	vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]
-- 		:sub(col, col)
-- 		:match("%s") == nil
-- end

cmp.setup({
    mapping = {
        ['<C-Space>'] = cmp.mapping.complete({}),
        ['<C-e>'] = cmp.mapping.close(),
        ['<C-u>'] = cmp.mapping.scroll_docs(-4),
        ['<C-d>'] = cmp.mapping.scroll_docs(4),
        ['<CR>'] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = false,
        }),

        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
                -- this will auto complete if our cursor in next to a word and we press tab
                -- elseif has_words_before() then
                --     cmp.complete()
            else
                fallback()
            end
        end, {"i", "s"}),

        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, {"i", "s"}),

    },
})

--local ok, cmp = pcall(require, "cmp")
--if not ok then
	--return
--end

--require("luasnip.loaders.from_vscode").lazy_load()

--cmp.setup({
	--snippet = {
		--expand = function(args)
			--require('luasnip').lsp_expand(args.body)
		--end,
	--},
	--mapping = {
		--["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
		--["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
		--["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
		--["<C-y>"] = cmp.config.disable,
		--["<C-e>"] = cmp.mapping({
			--i = cmp.mapping.abort(),
			--c = cmp.mapping.close(),
		--}),
		--["<CR>"] = cmp.mapping.confirm({ select = true }),
	--},
	--sources = cmp.config.sources({
		--{ name = "nvim_lsp" },
		--{ name = 'luasnip' },
	--}, {
		--{ name = "buffer" },
		--{ name = "path" },
	--}),
	--view = {
		--entries = "native"
	--},
	--experimental = {
		--ghost_text = true,
	--},
--})

---- vim.api.nvim_set_keymap('i', '<C-E>', '<cmd>lua require("luasnip").jump()<cr>', {})
--vim.api.nvim_set_keymap('i', '<C-k>', '<plug>luasnip-expand-or-jump', {})
--vim.api.nvim_set_keymap('s', '<C-k>', '<plug>luasnip-expand-or-jump', {})
---- vim.api.nvim_set_keymap('i', '<C-j>', '<plug>luasnip-jump-prev', {})
---- vim.api.nvim_set_keymap('s', '<C-j>', '<plug>luasnip-jump-prev', {})

