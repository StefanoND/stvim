local M = {}

local configs = require("plugins.snacks.configs")
local funcs = require("config.functions")

M.conf = {
  enabled = true,
  replace_netrw = true,
}

M.pkr = vim.tbl_deep_extend("force", configs.files, {
  auto_close = true,
  -- cwd = vim.fn.getcwd(),
  layout = {
    preview = true,
    layout = {
      zindex = 35, -- 1 Below Lazy window
      box = "vertical",
      width = 0,
      height = 0.999,
      border = "top",
      title = " {title} {live} {flags}",
      title_pos = "left",
      {
        box = "horizontal",
        {
          box = "vertical",
          { win = "input", height = 1, border = "rounded" },
          { win = "list", border = "rounded" },
        },
        { win = "preview", title = "{preview}", width = 0.8, border = "rounded" },
      },
    },
  },
  exclude = funcs.mergeTablesNoDup(
    funcs.ignore(".allignore"),
    funcs.ignore(".explorerignore"),
    configs.excludeAll,
    configs.excludeExplorer
  ),
})

return M
