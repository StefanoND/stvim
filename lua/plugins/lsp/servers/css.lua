local lspconfig = require("config.lsp.setup")

return {
  lspconfig.setupServer("tailwindcss", {
    filetypes_exclude = { "markdown" },
    includeLanguages = {
      elixir = "html-eex",
      eelixir = "html-eex",
      heex = "html-eex",
    },
    on_attach = function(client, bufnr)
      print("Hello CSS")
    end,
  }),
}
