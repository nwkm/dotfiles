-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost",
  { callback = function() vim.highlight.on_yank({ higroup = 'IncSearch', timeout = 100 }) end })
-- Disable diagnostics in node_modules (0 is current buffer only)
vim.api.nvim_create_autocmd("BufRead", { pattern = "*/node_modules/*", command = "lua vim.diagnostic.disable(0)" })
vim.api.nvim_create_autocmd("BufNewFile", { pattern = "*/node_modules/*", command = "lua vim.diagnostic.disable(0)" })
-- Enable spell checking for certain file types
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, { pattern = { "*.txt", "*.md", "*.tex" },
  command = "setlocal spell" })

-- Attach specific keybindings in which-key for specific filetypes
local present, _ = pcall(require, "which-key")
if not present then
  return
end
local _, pwk = pcall(require, "plugins.which-key.wk-config")

vim.api.nvim_create_autocmd("BufEnter", { pattern = "*.md",
  callback = function() pwk.attach_markdown(0) end })
vim.api.nvim_create_autocmd("BufEnter", { pattern = { "*.ts", "*.tsx" },
  callback = function() pwk.attach_typescript(0) end })
vim.api.nvim_create_autocmd("BufEnter", { pattern = { "package.json" },
  callback = function() pwk.attach_npm(0) end })
vim.api.nvim_create_autocmd("BufEnter", { pattern = { "*test.js", "*test.ts", "*test.tsx" },
  callback = function() pwk.attach_jest(0) end })
vim.api.nvim_create_autocmd("FileType", { pattern = "spectre_panel",
  callback = function() pwk.attach_spectre(0) end })
vim.api.nvim_create_autocmd("FileType", { pattern = "NvimTree",
  callback = function() pwk.attach_nvim_tree(0) end })

local attach_to_buffer = function (output_bufnr, pattern, command)
  vim.api.nvim_create_autocmd("BufWriteFile", {
    group = vim.api.nvim_create_augroup("nw-autorun", { clear = true }),
    pattern = pattern,
    callback = function()
      local append_data = function(_, data)
        if data then
          vim.api.nvim_buf_set_lines(output_bufnr, -1, -1, false, data)
        end
      end

      vim.api.nvim_buf_set_lines(output_bufnr, 0, -1, false, { "index output:" })
      vim.fn.jobstart(command, {
        stdout_buffered = true,
        on_stdout = append_data,
        on_stderr = append_data,
      })
    end
  })
end

vim.api.nvim_create_user_command("AutoRun", function()
  print "AutoRun starts ..."
  local bufnr = vim.fn.input "Bufnr: "
  local pattern = vim.fn.input "Pattern: "
  local command = vim.split(vim.fn.input "Command: ", " ")
  attach_to_buffer(tonumber(bufnr), pattern, command)
end, {})

local present_lualine, lualine = pcall(require, "lualine")
if not present_lualine then
  return
end
vim.api.nvim_create_autocmd("RecordingEnter", {
  callback = function()
      lualine.refresh({
          place = { "statusline" },
      })
  end,
})

vim.api.nvim_create_autocmd("RecordingLeave", {
  callback = function()
      -- This is going to seem really weird!
      -- Instead of just calling refresh we need to wait a moment because of the nature of
      -- `vim.fn.reg_recording`. If we tell lualine to refresh right now it actually will
      -- still show a recording occuring because `vim.fn.reg_recording` hasn't emptied yet.
      -- So what we need to do is wait a tiny amount of time (in this instance 50 ms) to
      -- ensure `vim.fn.reg_recording` is purged before asking lualine to refresh.
      local timer = vim.loop.new_timer()
      timer:start(
          50,
          0,
          vim.schedule_wrap(function()
              lualine.refresh({
                  place = { "statusline" },
              })
          end)
      )
  end,
})