local lspconfig = require("config.lsp.setup")
local capabilities = require("config.lsp.capabilities").capabilities

return {
  lspconfig.setupServer("bashls", {
    capabilities = capabilities,
    on_attach = function(client, bufnr)
      print("Hello bash")
    end,
  }),
}
