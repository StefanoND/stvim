local lspconfig = require("config.lsp.setup")
local capabilities = require("config.lsp.capabilities").capabilities

return {
  lspconfig.setupServer("biome", {
    cmd = { "biome", "lsp-proxy" },
    filetypes = {
      -- "javascript",
      -- "javascriptreact",
      "json",
      "jsonc",
      -- "typescript",
      -- "typescript.tsx",
      -- "typescriptreact",
      -- "astro",
      -- "svelte",
      -- "vue",
      -- "css",
    },
    -- root_dir = util.root_pattern("biome.json"),
  }),
  lspconfig.setupServer("jsonls", {
    flags = { allow_incremental_sync = true, debounce_text_changes = 500 },
    capabilities = capabilities,
    settings = {
      json = {
        schemas = {
          {
            description = "Biome configuration schema",
            fileMatch = { "biome.json" },
            url = "https://biomejs.dev/schemas/1.9.4/schema.json",
          },
        },
      },
    },
    on_attach = function(client, bufnr)
      print("Hello json")
    end,
  }),
}
