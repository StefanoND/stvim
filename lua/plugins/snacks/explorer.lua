local M = {}

local configs = require("plugins.snacks.configs")
local funcs = require("config.functions")

M.explorer = {
  enabled = true,
  replace_netrw = true,
}

M.picker = vim.tbl_deep_extend("force", configs.files, {
  auto_close = true,
  layout = {
    preview = true,
    layout = {
      zindex = 37, -- 1 Below Lazy window
      box = "vertical",
      -- backdrop = false,
      -- row = -1,
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
  exclude = {
    funcs.ignoreAll(),
    funcs.ignoreExplorer(),
    configs.ignoreAll,
    configs.ignoreExplorer
  },
})

return M
