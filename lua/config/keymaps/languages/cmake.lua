local M = {}

local wk = require("which-key")

M.keymaps = wk.add({
  {
    mode = { "n" },
    { "<leader>cg", "<cmd>CMakeGenerate<CR>", desc = "Generate CMakeLists.txt" },
    { "<leader>cb", "<cmd>CMakeBuild<CR>", desc = "Build project" },
    { "<leader>cq", "<cmd>CMakeClose<CR>", desc = "Close project" },
    { "<leader>cc", "<cmd>CMakeClean<CR>", desc = "Clean project" },
  },
})

return M.keymaps
