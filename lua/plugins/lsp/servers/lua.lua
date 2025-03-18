local lspconfig = require("config.lsp.setup")
local capabilities = require("config.lsp.capabilities").capabilities

-- local setupDap = function ()
--   local dap = require("dap")
--   dap.configurations.lua = {
--     {
--       type = "nlua",
--       request = "attach",
--       name = "Attach to running Neovim instance",
--     },
--   }
--   dap.adapters.nlua = function(callback, config)
--     callback({ type = "server", host = config.host or "127.0.0.1", port = config.port or 8086 })
--   end
-- end

return {
  lspconfig.setupServer("lua_ls", {
    capabilities = capabilities,
    flags = { allow_incremental_sync = true, debounce_text_changes = 500 },
    on_attach = function(client, bufnr)
      -- setupDap()

      print("Hello Lua")
    end,
    settings = { -- custom settings for lua
      Lua = {
        -- make the language server recognize "vim" global
        diagnostics = {
          globals = { "vim" },
        },
        codelens = {
          enable = true,
          events = { "BufWritePost", "BufEnter", "CursorHold", "InsertLeave", "TextChanged" },
        },
        workspace = {
          -- make language server aware of runtime files
          library = {
            [vim.fn.expand("$VIMRUNTIME/lua")] = true,
            [vim.fn.stdpath("config") .. "/lua"] = true,
          },
        },
      },
    },
  }),
}
