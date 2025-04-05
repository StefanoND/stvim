local M = {}

local wk = require("which-key")

M.keymaps = wk.add({
  mode = { "n" },
  -- run [--debug] [EXTRA ARGS] - Run the editor for the Unreal project
  { "<leader>uer", ":!ue run<CR>", desc = "Run the editor" },

  -- gen [EXTRA ARGS] - Generate IDE project files for the Unreal project
  { "<leader>ueg", ":!ue gen<CR>", desc = "Generate IDE project files" },

  -- build [CONFIGURATION] [TARGET] - Build the Editor modules for the Unreal project or plugin
  { "<leader>ueb", ":!ue build<CR>", desc = "Build the Editor modules for Project or Plugin" },

  -- clean - Clean build artifacts for the Unreal project or plugin
  { "<leader>uec", ":!ue clean<CR>", desc = "Clean build artifacts for project or plugin" },

  -- test [--withrhi] [--list] [--all] [--filter FILTER] TEST1 TEST2 TESTN [-- EXTRA ARGS]
  -- Run automation tests for the Unreal project
  { "<leader>uet", ":!ue test<CR>", desc = "Run automation tests" },

  -- package [PROJECT CONFIGURATION] [EXTRA UAT ARGS] - Package a build of the Unreal project or plugin
  -- in the current directory, storing the result in a subdirectory named "dist".
  -- Default configuration for projects is Shipping.
  { "<leader>uep", ":!ue package<CR>", desc = "Package a build of the project or plugin" },
})

return M.keymaps
