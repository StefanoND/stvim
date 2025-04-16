local M = {}

local configs = require("plugins.editor.snacks.configs")
local funcs = require("config.functions")

M.pkr = vim.tbl_deep_extend("force", configs.files, {
  exclude = funcs.mergeTablesNoDup(
    funcs.ignore(".allignore"),
    funcs.ignore(".grepignore"),
    configs.excludeAll,
    configs.excludeGrep
  ),
})

return M
