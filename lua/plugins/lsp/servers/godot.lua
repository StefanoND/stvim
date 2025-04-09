local lspconfig = require("config.lsp.setup")

return {
  lspconfig.setupServer("gdscript", {
    -- cmd = vim.lsp.rpc.connect("127.0.0.1", 6007),
    on_attach = function(client, bufnr)
      print("Hello Godot")
    end,
  }),
}
