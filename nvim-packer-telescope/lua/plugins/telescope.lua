local present, telescope = pcall(require, "telescope")

if not present then
	return
end

local devicons = require("nvim-web-devicons")
local entry_display = require("telescope.pickers.entry_display")

local filter = vim.tbl_filter
local map = vim.tbl_map

function gen_from_buffer_like_leaderf(opts)
  opts = opts or {}
  local default_icons, _ = devicons.get_icon("file", "", {default = true})

  local bufnrs = filter(function(b)
    return 1 == vim.fn.buflisted(b)
  end, vim.api.nvim_list_bufs())

  local max_bufnr = math.max(unpack(bufnrs))
  local bufnr_width = #tostring(max_bufnr)

  local max_bufname = math.max(
    unpack(
      map(function(bufnr)
        return vim.fn.strdisplaywidth(vim.fn.fnamemodify(vim.api.nvim_buf_get_name(bufnr), ":p:t"))
      end, bufnrs)
    )
  )

  local displayer = entry_display.create {
    separator = " ",
    items = {
      { width = bufnr_width },
      { width = 4 },
      { width = vim.fn.strwidth(default_icons) },
      { width = max_bufname },
      { remaining = true },
    },
  }

  local make_display = function(entry)
    return displayer {
      {entry.bufnr, "TelescopeResultsNumber"},
      {entry.indicator, "TelescopeResultsComment"},
      {entry.devicons, entry.devicons_highlight},
      entry.file_name,
      {entry.dir_name, "Comment"}
    }
  end

  return function(entry)
    local bufname = entry.info.name ~= "" and entry.info.name or "[No Name]"
    local hidden = entry.info.hidden == 1 and "h" or "a"
    local readonly = vim.api.nvim_buf_get_option(entry.bufnr, "readonly") and "=" or " "
    local changed = entry.info.changed == 1 and "+" or " "
    local indicator = entry.flag .. hidden .. readonly .. changed

    local dir_name = vim.fn.fnamemodify(bufname, ":p:h")
    local file_name = vim.fn.fnamemodify(bufname, ":p:t")

    local icons, highlight = devicons.get_icon(bufname, string.match(bufname, "%a+$"), { default = true })

    return {
      valid = true,

      value = bufname,
      ordinal = entry.bufnr .. " : " .. file_name,
      display = make_display,

      bufnr = entry.bufnr,

      lnum = entry.info.lnum ~= 0 and entry.info.lnum or 1,
      indicator = indicator,
      devicons = icons,
      devicons_highlight = highlight,

      file_name = file_name,
      dir_name = dir_name,
    }
  end
end

telescope.setup({
	defaults = {
	  layout_config = { prompt_position = 'top' },
	  layout_strategy = 'horizontal',
	  sorting_strategy = 'ascending',
	  use_less = false,
	  prompt_prefix = "❯❯ ",
	  selection_caret = "❯ ",
	  entry_prefix = "  ",
	  multi_icon = " ",
	  dynamic_preview_title = true,
    mappings = {
      i = {
        ["<Esc>"] = require('telescope.actions').close
      }
    },
	},
	-- pickers = {
    --     buffers = {
    --         ignore_current_buffer = true,
    --         sort_lastused = true,
	-- 		entry_maker = gen_from_buffer_like_leaderf()
    --     },
  	-- },
})

-- 🔭 Extensions --
require("telescope").load_extension "file_browser"
require("telescope").load_extension "ui-select"
require("telescope").load_extension "fzf"
require("telescope").load_extension "command_palette"
require("telescope").load_extension "bookmarks"
require("telescope").load_extension "projects"


local telescope_builtin = require("telescope.builtin")

-- Normal file finder
local function find_files()
	telescope_builtin.find_files(require("telescope.themes").get_dropdown({
	  	find_command = { 'rg', '--files', '--iglob', '!.git', '--hidden' },
		  previewer = false,
	}))
end

-- Normal buffer finder
local function find_buffers()
	telescope_builtin.buffers(require("telescope.themes").get_dropdown({
      prompt_title = '',
      results_title='﬘',
      winblend = 3,
      layout_strategy = 'vertical',
      layout_config = { width = 0.60, height = 0.55 },
		  previewer = false,
	}))
end

-- Code finder
local function live_grep()
	telescope_builtin.live_grep({ only_sort_text = true })
end

-- Config file finder
local function find_config_files()
	local configdir = vim.fn.stdpath('config')
	
	telescope_builtin.find_files({
		find_command = { 'rg', '--files', '--iglob', '!.git', '--hidden', configdir },
		previewer = false,
	})
end

local function file_explorer()
	telescope.extensions.file_browser.file_browser {
	  prompt_title = " File Browser",
	  path_display = { "smart" },
	  cwd = "~",
	  layout_strategy = "horizontal",
	  layout_config = { preview_width = 0.65, width = 0.75 },
	}
end

local function find_recent_projects()
  telescope.extensions.projects.projects({
    previewer = false,
  })
end

local utils = require('config.utils')

local function find_project_files()
  local _, ret, stderr = utils.get_os_command_output {
    "git",
    "rev-parse",
    "--is-inside-work-tree",
  }

  local gopts = {}
  local fopts = {}

  gopts.prompt_title = " Find"
  gopts.prompt_prefix = "  "
  gopts.results_title = " Repo Files"

  fopts.hidden = true
  fopts.file_ignore_patterns = {
    ".vim/",
    ".local/",
    ".cache/",
    "Documents/",
    "Downloads/",
    ".git/",
    "Dropbox/.*",
    "Library/.*",
    ".rustup/.*",
    "Movies/",
    ".cargo/registry/",
  }

  if ret == 0 then
    telescope_builtin.git_files(gopts)
  else
    fopts.results_title = "CWD: " .. vim.fn.getcwd()
    telescope_builtin.find_files(fopts)
  end
end

local nmap = require('config.utils').nmap

nmap('<C-p>', find_files)
nmap('<C-g>', live_grep)
nmap('<C-b>', find_buffers)
nmap('<Leader>ff', find_project_files)
nmap('<Leader>fe', file_explorer)
nmap('<Leader>fc', find_config_files)

nmap(
  "<Leader>bf",
  [[<Cmd>lua require'telescope.builtin'.current_buffer_fuzzy_find()<CR>]],
  { noremap = true, silent = true }
)
-- search Brave bookmarks & go
nmap(
  "<Leader>bm",
  [[<Cmd>lua require'telescope'.extensions.bookmarks.bookmarks()<CR>]],
  { noremap = true, silent = true }
)
-- git_commits (log) git log
nmap(
  "gl",
  [[<Cmd>lua require'telescope.builtin'.git_commits()<CR>]],
  { noremap = true, silent = true }
)
-- git_status - <tab> to toggle staging
nmap(
  "gs",
  [[<Cmd>lua require'telescope.builtin'.git_status()<CR>]],
  { noremap = true, silent = true }
)
