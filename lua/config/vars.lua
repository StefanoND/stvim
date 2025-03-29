local M = {}

-- local vars = require("config.vars")

M.getOS = function()
  return vim.uv.os_uname().sysname
end

M.getOSLowerCase = function()
  return vim.uv.os_uname().sysname:lower()
end

M.maxFileSize = 2 * 1024 * 1024

return M
