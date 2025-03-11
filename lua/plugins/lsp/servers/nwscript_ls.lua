local lsp = require("lsp-zero")
lsp.extend_lspconfig()

lsp.setup()

return {
  require("lspconfig").nwscript_ls.setup({
    on_attach = function(client, bufnr)
      print("Hello NWScript")
    end,
  }),
}
