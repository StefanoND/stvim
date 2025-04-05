local lspconfig = require("config.lsp.setup")
local capabilities = require("config.lsp.capabilities").capabilities

return {
  lspconfig.setupServer("fish_lsp", {
    cmd_env = { fish_lsp_show_client_popups = false },
    flags = { allow_incremental_sync = true, debounce_text_changes = 500 },
    capabilities = capabilities,
    on_attach = function(client, bufnr)
      print("Hello fish")
    end,
  }),
}
