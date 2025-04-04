local M = {}

local vars = require("config.vars")

M.bigfile = {
  enabled = true,
  notify = true,
  size = vars.maxFileSize
}

return M
