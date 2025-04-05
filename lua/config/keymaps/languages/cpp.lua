local M = {}

local wk = require("which-key")

M.keymaps = wk.add({
  mode = { "n" },
  { "<leader>cR", "<cmd>ClangdSwitchSourceHeader<cr>", desc = "Switch Source/Header (C/C++)" },
  -- switch between header and source file creating if any are missing
  {
    "<M-o>",
    function()
      local filename = vim.fn.expand("%:p")
      local new_filename

      if string.match(filename, ".h$") then
        new_filename = string.gsub(filename, ".h$", ".cpp")
      elseif string.match(filename, ".cpp$") then
        new_filename = string.gsub(filename, ".cpp$", ".h")
      end

      if new_filename then
        vim.cmd("e " .. new_filename)
      end
    end,
    desc = "Switch Source/Header (C/C++), create them if needed.",
  },
})

return M.keymaps
