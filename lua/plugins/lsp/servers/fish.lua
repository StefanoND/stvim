local lspconfig = require("config.lsp.setup")

return {
  lspconfig.setupServer("fish_lsp", {
    cmd_env = { fish_lsp_show_client_popups = false },
    on_attach = function(client, bufnr)
      print("Hello fish")
    end,
  }),
}
