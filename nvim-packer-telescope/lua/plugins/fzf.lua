local u = require("config.utils")

require("fzf-lua").setup({
    keymap = {
        fzf = {
            ["ctrl-q"] = "select-all+accept",
            ["ctrl-c"] = "abort",
        },
    },
    winopts = {
        preview = {
            scrollbar = false,
        },
    },
    fzf_opts = {
        ["--layout"] = "reverse",
    },
    files = {
    previewer = false,
        winopts = {
            width = 0.5,
            height = 0.5
        },
        actions = {
            ["ctrl-e"] = function(selected)
                for i, item in ipairs(selected) do
                    local command = i == 1 and "edit" or i % 2 == 0 and "vsplit" or "split"
                    vim.cmd(string.format("%s %s", command, item))
                end
            end,
        },
    },
})

-- fzf.vim-like commands
u.command("Files", "FzfLua files")
u.command("Rg", "FzfLua live_grep_glob")
u.command("BLines", "FzfLua grep_curbuf")
u.command("GrepCword", "FzfLua grep_cWORD")
u.command("History", "FzfLua oldfiles")
u.command("Buffers", "FzfLua buffers")
u.command("BCommits", "FzfLua git_bcommits")
u.command("Commits", "FzfLua git_commits")
u.command("HelpTags", "FzfLua help_tags")
u.command("ManPages", "FzfLua man_pages")
u.command("GitBranches", "FzfLua git_branches")
u.command("GrepClipboard", function()
    -- remove newlines, since they'll break the search
    local search = vim.fn.getreg("*"):gsub("\n", "")
    require("fzf-lua").grep({ search = search })
end)

u.nmap("<C-p>", "<Cmd>Files<CR>")
u.nmap("<Leader>fb", "<Cmd>GitBranches<CR>")
u.nmap("<Leader>fs", "<Cmd>Rg<CR>")
u.nmap("<Leader>ft", "<Cmd>HelpTags<CR>")
u.nmap("<Leader>fh", "<Cmd>History<CR>")
u.nmap("<Leader>fw", "<Cmd>GrepCword<CR>")
u.nmap("<Leader>fc", "<Cmd>GrepClipboard<CR>")
u.nmap("<Leader><Leader>", "<Cmd>Buffers<CR>")
u.nmap("<LocalLeader><LocalLeader>", "<Cmd>BLines<CR>")

u.command("LspRef", "FzfLua lsp_references")
u.command("LspSym", "FzfLua lsp_workspace_symbols")
u.command("LspAct", "FzfLua lsp_code_actions")
u.command("LspDef", function()
    require("fzf-lua").lsp_definitions({ jump_to_single_result = true })
end)
