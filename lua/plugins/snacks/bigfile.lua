local M = {}

local vars = require("config.vars")

M.conf = {
  enabled = true,
  notify = true,
  size = vars.maxFileSize,
}

return M
