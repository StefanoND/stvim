local M = {}

local wk = require("which-key")

M.keymaps = wk.add({
  {
    mode = { "n" },
  },
})

return M.keymaps
