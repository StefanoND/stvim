local M = {}

local vars = require("config.vars")

M.conf = {
  enabled = true,
  animate = {
    enabled = false,
  },
  hl = vars.highlights,
  scope = {
    hl = vars.highlights,
  },
  chunk = {
    enabled = true,
    char = {
      corner_top = "╭",
      corner_bottom = "╰",
    },
    hl = vars.highlights,
  },
}

return M
