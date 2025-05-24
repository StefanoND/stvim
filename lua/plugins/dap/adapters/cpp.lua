local M = {}

M.adapter = function()
  local dap = require("dap")
  -- C/C++
  if not dap.adapters["codelldb"] then
    require("dap").adapters["codelldb"] = {
      -- Executable
      type = "executable",
      command = vim.fn.exepath("codelldb"),

      -- -- Server
      -- type = "server",
      -- port = "${port}",
      -- executable = {
      --   command = vim.fn.exepath("codelldb"),
      --   args = { "--port", "${port}" },
      -- },

      -- -- Server from separate terminal
      -- type = "server",
      -- host = "127.0.0.1",
      -- port = 13000,
      -- executable = {
      --   command = vim.fn.exepath("codelldb"),
      --   args = { "--port", 13000 },
      -- },
    }
  end
  dap.configurations.cpp = {
    {
      name = "Launch file",
      type = "codelldb",
      request = "launch",
      program = function()
        return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
      end,
      cwd = "${workspaceFolder}",
    },
    -- {
    --   name = "Attach to process",
    --   type = "codelldb",
    --   request = "attach",
    --   pid = require("dap.utils").pick_process,
    --   cwd = "${workspaceFolder}",
    -- },
  }
  dap.configurations.c = dap.configurations.cpp
end

return M.adapter()
