local M = {}

local configs = require("plugins.snacks.configs")
local funcs = require("config.functions")

M.picker = vim.tbl_deep_extend("force", configs.files, {
  cmd = "rg",
  exclude = {
    funcs.ignoreAll(),
    funcs.ignoreFiles(),
    configs.ignoreAll,
    configs.ignoreFiles
  },
})

return M
