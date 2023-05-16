local M = {}

M.setup = {
    automatic_installation = false,

    ui = {
        -- Whether to automatically check for outdated servers when opening the UI window.
        check_outdated_servers_on_open = true,
        -- The border to use for the UI window. Accepts same border values as |nvim_open_win()|.
        border = "rounded",
        icons = {
            server_installed = "✓",
            server_pending = "➜",
            server_uninstalled = "✗",
        },
        keymaps = {
            -- Keymap to expand a server in the UI
            toggle_server_expand = "<CR>",
            -- Keymap to install the server under the current cursor position
            install_server = "i",
            -- Keymap to reinstall/update the server under the current cursor position
            update_server = "u",
            -- Keymap to check for new version for the server under the current cursor position
            check_server_version = "c",
            -- Keymap to update all installed servers
            update_all_servers = "U",
            -- Keymap to check which installed servers are outdated
            check_outdated_servers = "C",
            -- Keymap to uninstall a server
            uninstall_server = "X",
        },
    },
    log_level = vim.log.levels.INFO,
    max_concurrent_installers = 4,
}

return M
