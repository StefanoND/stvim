local lspconfig = require("config.lsp.setup")
local capabilities = require("config.lsp.capabilities").capabilities

return {
  lspconfig.setupServer("gdscript", {
    flags = { allow_incremental_sync = true, debounce_text_changes = 500 },
    capabilities = capabilities,
    -- cmd = vim.lsp.rpc.connect("127.0.0.1", 6007),
    on_attach = function(client, bufnr)
      vim.opt.tabstop = 4
      vim.opt.softtabstop = 4
      vim.opt.shiftwidth = 4
      vim.opt.expandtab = false -- Don't expand tab to spaces
      vim.opt.smartindent = true
      vim.opt.autoindent = true -- Copy indent from current line when starting a new one
      print("Hello Godot")
    end,
  }),
}
