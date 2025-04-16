local M = {}

local configs = require("plugins.editor.snacks.configs")

M.pkr = {
  finder = "vim_registers",
  format = "register",
  preview = "preview",
  confirm = { "copy", "close" },
}

return M
