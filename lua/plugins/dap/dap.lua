local keys = require("config.keymaps.dap")

local servers = function()
  local dap = require("dap")

  -- C/C++
  if not dap.adapters["codelldb"] then
    require("dap").adapters["codelldb"] = {
      type = "server",
      host = "localhost",
      port = "${port}",
      executable = {
        command = "codelldb",
        args = {
          "--port",
          "${port}",
        },
      },
    }
  end
  for _, lang in ipairs({ "c", "cpp" }) do
    dap.configurations[lang] = {
      {
        type = "codelldb",
        request = "launch",
        name = "Launch file",
        program = function()
          return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
        end,
        cwd = "${workspaceFolder}",
      },
      {
        type = "codelldb",
        request = "attach",
        name = "Attach to process",
        pid = require("dap.utils").pick_process,
        cwd = "${workspaceFolder}",
      },
    }
  end

  -- C#
  if not dap.adapters["netcoredbg"] then
    require("dap").adapters["netcoredbg"] = {
      type = "executable",
      command = vim.fn.exepath("netcoredbg"),
      args = { "--interpreter=vscode" },
      options = {
        detached = false,
      },
    }
  end
  for _, lang in ipairs({ "cs", "fsharp", "vb" }) do
    if not dap.configurations[lang] then
      dap.configurations[lang] = {
        {
          type = "netcoredbg",
          name = "Launch file",
          request = "launch",
          ---@diagnostic disable-next-line: redundant-parameter
          program = function()
            return vim.fn.input("Path to dll: ", vim.fn.getcwd() .. "/", "file")
          end,
          cwd = "${workspaceFolder}",
        },
      }
    end
  end

  -- Rust
  dap.configurations.rust = dap.configurations.cpp

  -- Typescript
  if not dap.adapters["pwa-node"] then
    require("dap").adapters["pwa-node"] = {
      type = "server",
      host = "localhost",
      port = "${port}",
      executable = {
        command = "node",
        -- 💀 Make sure to update this path to point to your installation
        args = {
          -- LazyVim.get_pkg_path("js-debug-adapter", "/js-debug/src/dapDebugServer.js"),
          vim.fn.stdpath("data") .. "/mason/bin/js-debug-adapter",
          "${port}",
        },
      },
    }
  end
  if not dap.adapters["node"] then
    dap.adapters["node"] = function(cb, config)
      if config.type == "node" then
        config.type = "pwa-node"
      end
      local nativeAdapter = dap.adapters["pwa-node"]
      if type(nativeAdapter) == "function" then
        nativeAdapter(cb, config)
      else
        cb(nativeAdapter)
      end
    end
  end

  local js_filetypes = { "typescript", "javascript", "typescriptreact", "javascriptreact" }

  local vscode = require("dap.ext.vscode")
  vscode.type_to_filetypes["node"] = js_filetypes
  vscode.type_to_filetypes["pwa-node"] = js_filetypes

  for _, language in ipairs(js_filetypes) do
    if not dap.configurations[language] then
      dap.configurations[language] = {
        {
          type = "pwa-node",
          request = "launch",
          name = "Launch file",
          program = "${file}",
          cwd = "${workspaceFolder}",
        },
        {
          type = "pwa-node",
          request = "attach",
          name = "Attach",
          processId = require("dap.utils").pick_process,
          cwd = "${workspaceFolder}",
        },
      }
    end
  end
end

-- Catppuccin compatibility
local catppuccin = function()
  local sign = vim.fn.sign_define

  local dapBreakpoint = {
    breakpoint = {
      text = "",
      texthl = "DapBreakpoint",
      linehl = "",
      numhl = "",
    },
    breakpointCondition = {
      text = "",
      texthl = "DapBreakpointCondition",
      linehl = "",
      numhl = "",
    },
    dapLogPoint = {
      text = "◆",
      texthl = "DapLogPoint",
      linehl = "",
      numhl = "",
    },
    rejected = {
      text = "",
      texthl = "LspDiagnosticsSignHint",
      linehl = "",
      numhl = "",
    },
    stopped = {
      text = "",
      texthl = "LspDiagnosticsSignInformation",
      linehl = "DiagnosticUnderlineInfo",
      numhl = "LspDiagnosticsSignInformation",
    },
  }

  sign("DapBreakpoint", dapBreakpoint.breakpoint)
  sign("DapBreakpointCondition", dapBreakpoint.breakpointCondition)
  sign("DapLogPoint", dapBreakpoint.dapLogPoint)
  sign("DapStopped", dapBreakpoint.stopped)
  sign("DapBreakpointRejected", dapBreakpoint.rejected)
end

return {
  "nvim-neotest/nvim-nio",
  "theHamsta/nvim-dap-virtual-text",
  {
    "rcarriga/nvim-dap-ui",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "theHamsta/nvim-dap-virtual-text",
    },
    keys = keys.dapUIKeymap,
  },
  {
    "mfussenegger/nvim-dap",
    after = { "mason" },
    dependencies = { "rcarriga/nvim-dap-ui", "theHamsta/nvim-dap-virtual-text" },
    keys = keys.dapKeymap,
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      catppuccin()
      servers()
      dapui.setup()
      require("nvim-dap-virtual-text").setup()
      require("overseer").enable_dap()

      dap.listeners.after.event_initialized.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.attach.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        dapui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        dapui.close()
      end

      -- vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })

      -- setup dap config by VsCode launch.json file
      local vscode = require("dap.ext.vscode")
      local json = require("plenary.json")
      vscode.json_decode = function(str)
        return vim.json.decode(json.json_strip_comments(str))
      end
    end,
  },
}
