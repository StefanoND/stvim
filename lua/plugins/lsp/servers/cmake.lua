local lspconfig = require("config.lsp.setup")
local capabilities = require("config.lsp.capabilities").capabilities

return {
  lspconfig.setupServer("cmake", {
    capabilities = capabilities,
    on_attach = function(client, bufnr)
      print("Hello CMake")
    end,
  }),
}
