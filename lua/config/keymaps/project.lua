local M = {}

local wk = require("which-key")

M.keymaps = wk.add({
  {
    mode = { "n" },
    { "<leader>pr", ":ProjectRoot<CR>", desc = "Project set root" },
  },
})

return M.keymaps
