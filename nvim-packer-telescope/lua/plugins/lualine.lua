local ok, lualine = pcall(require, "lualine")
if not ok then
  return
end

lualine.setup({
    options = {
        theme = "ayu",
        disabled_types = { "NvimTree" },
    },
    sections = {
        lualine_b = { "branch", "diff" },
        --lualine_c = { 'g:coc_status' },
        lualine_x = { "filetype" },
    },
    --globalstatus = true
})
