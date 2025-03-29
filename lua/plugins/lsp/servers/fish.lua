local lspconfig = require("config.lsp.setup")
local capabilities = require("config.lsp.capabilities").capabilities

return {
  lspconfig.setupServer("fish_lsp", {
    cmd_env = { fish_lsp_show_client_popups = false },
    flags = { allow_incremental_sync = true, debounce_text_changes = 500 },
    capabilities = capabilities,
    on_attach = function(client, bufnr)
      vim.opt.tabstop = 4
      vim.opt.softtabstop = 4
      vim.opt.shiftwidth = 4
      vim.opt.expandtab = true -- Expand tab to spaces
      vim.opt.smartindent = true
      vim.opt.autoindent = true -- Copy indent from current line when starting a new one
      print("Hello fish")
    end,
  }),
}
