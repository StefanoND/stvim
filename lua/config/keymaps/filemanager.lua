local M = {}

local wk = require("which-key")

M.keymaps = wk.add({
  mode = { "n" },
  -- { "<leader>op", ":NvimTreeToggle<CR>", desc = "Open file explorer" },
  { "<leader>op", ":Neotree toggle<CR>", desc = "Open file explorer" },
  -- { "<leader>op", ":CHADopen<CR>", desc = "Open file explorer" },
})

return M.keymaps
