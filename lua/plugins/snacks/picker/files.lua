local M = {}

local configs = require("plugins.snacks.configs")
local funcs = require("config.functions")

M.pkr = vim.tbl_deep_extend("force", configs.files, {
  cmd = "rg",
  exclude = funcs.mergeTablesNoDup(
    funcs.ignore(".allignore"),
    funcs.ignore(".filesignore"),
    configs.excludeAll,
    configs.excludeFiles
  ),
})

return M
