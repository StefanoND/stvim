local M = {}

local configs = require("plugins.snacks.configs")
local funcs = require("config.functions")

M.picker = vim.tbl_deep_extend("force", configs.files, {
  exclude = vim.tbl_deep_extend(
    "force",
    funcs.ignoreAll(),
    funcs.ignoreGrep(),
    configs.excludeAll,
    configs.excludeGrep
  ),
})

return M
