local lspconfig = require("config.lsp.setup")
local funcs = require("config.functions")

return {
  lspconfig.setupServer("biome", {
    cmd = { "biome", "lsp-proxy" },
    root_dir = funcs.getRoot(),
  }),
  lspconfig.setupServer("marksman", {
    on_attach = function(client, bufnr)
      print("Hello markdown")
    end,
  }),
}
