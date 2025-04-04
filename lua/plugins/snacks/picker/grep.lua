local M = {}

local configs = require("plugins.snacks.configs")
local funcs = require("config.functions")

M.picker = vim.tbl_deep_extend("force", configs.files, {
  exclude = {
    funcs.ignoreAll(),
    funcs.ignoreGrep(),
    configs.ignoreAll,
    configs.ignoreGrep
  },
})

return M
