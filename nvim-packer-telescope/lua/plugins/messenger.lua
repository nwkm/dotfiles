vim.g.git_messenger_floating_win_opts = { border = 'single' }

local u = require("config.utils")

u.nmap("gm", ":GitMessenger<CR>")