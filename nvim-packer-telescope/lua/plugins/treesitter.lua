local ok, treesitter = pcall(require, "nvim-treesitter.configs")
if not ok then
    return
end

local utils = require("config.utils")
local treesitter_parsers = require('nvim-treesitter.parsers')

-- local ft_to_parser = treesitter_parsers.filetype_to_parsername
-- ft_to_parser.zsh = 'bash'

local parsers = treesitter_parsers.available_parsers()

-- local hlmap = vim.treesitter.highlighter.hl_map
-- hlmap.custom_type = 'TSCustomType'

local indent = {
    'tsx',
    'typescript',
    'vue',
    'javascript',
}

treesitter.setup {
  ensure_installed = {
      "bash",
      "c",
      "cpp",
      "go",
      "javascript",
      "typescript",
      "json",
      "jsonc",
      "jsdoc",
      "lua",
      "python",
      "rust",
      "html",
      "css",
      "toml",
      "tsx",
      -- for `nvim-treesitter/playground`
      "query",
  },
  indent = {
    enable = false,
    disable = utils.difference(parsers, indent),
  },
  highlight = {
    enabled = true
  },
  autotag = {
    enable = true,
  },
  textobjects = {
    select = {
      enable  = true,
      keymaps = {
        ["ac"] = "@comment.outer"      ,
        ["ic"] = "@class.inner"      ,
        ["ab"] = "@block.outer"      ,
        ["ib"] = "@block.inner"      ,
        ["af"] = "@function.outer"   ,
        ["if"] = "@function.inner"   ,
        -- Leader mappings, dups for whichkey
        ["<Leader><Leader>ab"] = "@block.outer"      ,
        ["<Leader><Leader>ib"] = "@block.inner"      ,
        ["<Leader><Leader>af"] = "@function.outer"   ,
        ["<Leader><Leader>if"] = "@function.inner"   ,
        ["<Leader><Leader>ao"] = "@class.outer"      ,
        ["<Leader><Leader>io"] = "@class.inner"      ,
        ["<Leader><Leader>aC"] = "@call.outer"       ,
        ["<Leader><Leader>iC"] = "@call.inner"       ,
        ["<Leader><Leader>ac"] = "@conditional.outer",
        ["<Leader><Leader>ic"] = "@conditional.inner",
        ["<Leader><Leader>al"] = "@loop.outer"       ,
        ["<Leader><Leader>il"] = "@loop.inner"       ,
        ["<Leader><Leader>ap"] = "@parameter.outer"  ,
        ["<Leader><Leader>ip"] = "@parameter.inner"  ,
        ["<Leader><Leader>is"] = "@scopename.inner"  ,
        ["<Leader><Leader>as"] = "@statement.outer"  ,
      },
    },
  },
  -- playground = {
  --   enable = true,
  --   disable = {},
  --   updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
  --   persist_queries = false, -- Whether the query persists across vim sessions
  --   keybindings = {
  --     toggle_query_editor = 'o',
  --     toggle_hl_groups = 'i',
  --     toggle_injected_languages = 't',
  --     toggle_anonymous_nodes = 'a',
  --     toggle_language_display = 'I',
  --     focus_language = 'f',
  --     unfocus_language = 'F',
  --     update = 'R',
  --     goto_node = '<cr>',
  --     show_help = '?',
  --   },
  -- },
}
