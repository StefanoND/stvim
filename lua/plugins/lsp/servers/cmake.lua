local lspconfig = require("config.lsp.setup")
local capabilities = require("config.lsp.capabilities").capabilities

return {
  lspconfig.setupServer("cmake", {
    flags = { allow_incremental_sync = true, debounce_text_changes = 500 },
    capabilities = capabilities,
    on_attach = function(client, bufnr)
      print("Hello CMake")
    end,
  }),
}
