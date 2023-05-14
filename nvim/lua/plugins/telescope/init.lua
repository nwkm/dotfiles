return {
    'nvim-telescope/telescope.nvim',
    dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-telescope/telescope-file-browser.nvim',
        'debugloop/telescope-undo.nvim',
        "cljoly/telescope-repo.nvim",
        { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    },
    lazy = false,
    branch = '0.1.x',
    cmd = 'Telescope',
    config = function()
        
        local actions    = require('telescope.actions')
        local mappings = {
            i = {
              ["<C-n>"] = actions.cycle_history_next,
              ["<C-p>"] = actions.cycle_history_prev,
      
              ["<C-j>"] = actions.move_selection_next,
              ["<C-k>"] = actions.move_selection_previous,
      
              ["<C-c>"] = actions.close,
      
              ["<Down>"] = actions.move_selection_next,
              ["<Up>"] = actions.move_selection_previous,
      
              ["<CR>"] = actions.select_default,
              ["<C-x>"] = actions.select_horizontal,
              ["<C-v>"] = actions.select_vertical,
              ["<C-t>"] = actions.select_tab,
      
              ["<C-u>"] = actions.preview_scrolling_up,
              ["<C-d>"] = actions.preview_scrolling_down,
      
              ["<PageUp>"] = actions.results_scrolling_up,
              ["<PageDown>"] = actions.results_scrolling_down,
      
              ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
              ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
              ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
              ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
              ["<C-l>"] = actions.complete_tag,
              ["<C-_>"] = actions.which_key, -- keys from pressing <C-/>
            },
      
            n = {
              ["<esc>"] = actions.close,
              ["<CR>"] = actions.select_default,
              ["<C-x>"] = actions.select_horizontal,
              ["<C-v>"] = actions.select_vertical,
              ["<C-t>"] = actions.select_tab,
      
              ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
              ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
              ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
              ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
      
              ["j"] = actions.move_selection_next,
              ["k"] = actions.move_selection_previous,
              ["H"] = actions.move_to_top,
              ["M"] = actions.move_to_middle,
              ["L"] = actions.move_to_bottom,
      
              ["<Down>"] = actions.move_selection_next,
              ["<Up>"] = actions.move_selection_previous,
              ["gg"] = actions.move_to_top,
              ["G"] = actions.move_to_bottom,
      
              ["<C-u>"] = actions.preview_scrolling_up,
              ["<C-d>"] = actions.preview_scrolling_down,
      
              ["<PageUp>"] = actions.results_scrolling_up,
              ["<PageDown>"] = actions.results_scrolling_down,
      
              ["?"] = actions.which_key,
            },
        }
        local opts = {
            defaults = {
                path_display = { 'smart' },
                file_ignore_patterns = { '.git/' },
                border            = true,
                hl_result_eol     = true,
                multi_icon        = '',
                vimgrep_arguments = {
                  'rg',
                  '--color=never',
                  '--no-heading',
                  '--with-filename',
                  '--line-number',
                  '--column',
                  '--smart-case'
                },
                git_icons = {
                    added = nw.icons.gitAdd,
                    changed = nw.icons.gitChange,
                    deleted = nw.icons.gitRemove,
                    copied = ">",
                    renamed = "➡",
                    unmerged = "‡",
                    untracked = "?",
                },
                layout_config     = {
                    horizontal = {
                      preview_cutoff = 120,
                    },
                    prompt_position = "top",
                },
                file_sorter       = require('telescope.sorters').get_fzy_sorter,
                -- prompt_prefix     = '  ',
                prompt_prefix     = " ",
                selection_caret   = " ",
                color_devicons    = true,
                git_icons         = git_icons,
                sorting_strategy  = "ascending",
                file_previewer    = require('telescope.previewers').vim_buffer_cat.new,
                grep_previewer    = require('telescope.previewers').vim_buffer_vimgrep.new,
                qflist_previewer  = require('telescope.previewers').vim_buffer_qflist.new,
                mappings          = {
                    i = {
                        ["<C-x>"] = false,
                        ["<C-j>"] = actions.move_selection_next,
                        ["<C-k>"] = actions.move_selection_previous,
                        ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
                        ["<C-s>"] = actions.cycle_previewers_next,
                        ["<C-a>"] = actions.cycle_previewers_prev,
                        -- ["<C-h>"] = "which_key",
                        ["<ESC>"] = actions.close,
                    },
                    n = {
                        ["<C-s>"] = actions.cycle_previewers_next,
                        ["<C-a>"] = actions.cycle_previewers_prev,
                    }
                }
            },
            -- pickers = {
            --     find_files = {
            --         find_command = { 'rg', '--files', '--hidden', '--glob', '!**/.git/*' },
            --     },
            -- },
            extensions = {
                fzf = {
                    theme = 'tokyonight',
                    fuzzy = true,
                    override_generic_sorter = true,
                    override_file_sorter = true,
                    case_mode = 'smart_case',
                },
                file_browser = {
                    theme = 'tokyonight',
                    hidden = true
                },
                undo = {
                    side_by_side = true,
                    layout_strategy = 'vertical',
                    layout_config = {
                        preview_height = 0.8
                    }
                }
            },
        }
        require('telescope').setup(opts)
        require('telescope').load_extension('file_browser')
        require('telescope').load_extension('undo')
        require('telescope').load_extension('fzf')
        require('telescope').load_extension('repo')
        require("telescope").load_extension("git_worktree")
    end,
}
