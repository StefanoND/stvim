local M = {}

M.adapter = function()
  local dap = require("dap")
  -- -- Rust
  -- dap.configurations.rust = dap.configurations.cpp
end

return M.adapter()
