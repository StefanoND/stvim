local lspconfig = require("config.lsp.setup")
local funcs = require("config.functions")

return {
  lspconfig.setupServer("biome", {
    cmd = { "biome", "lsp-proxy" },
    root_dir = funcs.getRoot(),
  }),
  lspconfig.setupServer("jsonls", {
    settings = {
      jsonls = {
        settings = {
          json = {
            format = { enable = true },
            validate = { enable = true },
            schemas = {
              {
                require("schemastore").json.schemas(),
              },
              {
                description = "Biome configuration schema",
                fileMatch = { "biome.json" },
                url = "https://biomejs.dev/schemas/1.9.4/schema.json",
              },
            },
          },
        },
      },
    },
    on_attach = function(client, bufnr)
      print("Hello json")
    end,
  }),
}
