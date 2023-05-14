-- =============================================================================
-- Genarated by lightline to lualine theme converter
--   https://gist.github.com/shadmansaleh/000871c9a608a012721c6acc6d7a19b9
-- License: MIT License
-- =============================================================================

local colors = {
  color2   = "#242b38",
  color3   = "#d4bfff",
  color4   = "#d9d7ce",
  color5   = "#272d38",
  color13  = "#bbe67e",
  color10  = "#59c2ff",
  color8   = "#f07178",
  color9   = "#607080",
  color11  = "#ffb86c",
  color12  = "#14ce14",
}

local ayu_mirage = {
  visual = {
    a = { fg = colors.color2, bg = colors.color3 , "bold", },
    b = { fg = colors.color4, bg = colors.color5 },
  },
  replace = {
    a = { fg = colors.color2, bg = colors.color8 , "bold", },
    b = { fg = colors.color4, bg = colors.color5 },
  },
  inactive = {
    a = { fg = colors.color4, bg = colors.color5 , "bold", },
    c = { fg = colors.color4, bg = colors.color2 },
    b = { fg = colors.color4, bg = colors.color5 },
  },
  normal = {
    a = { fg = colors.color2, bg = colors.color10 , "bold", },
    c = { fg = colors.color9, bg = colors.color2 },
    b = { fg = colors.color4, bg = colors.color5 },
  },
  insert = {
    a = { fg = colors.color2, bg = colors.color13 , "bold", },
    b = { fg = colors.color4, bg = colors.color5 },
  },
  command = {
    a = { fg = colors.color2, bg = colors.color12 , "bold", },
    c = { fg = colors.color2, bg = colors.color2 },
    b = { fg = colors.color4, bg = colors.color5 },
  },
}

return ayu_mirage
