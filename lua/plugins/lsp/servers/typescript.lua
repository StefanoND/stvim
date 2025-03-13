local lspconfig = require("config.lsp.setup")
local capabilities = require("config.lsp.capabilities").capabilities

local servers = { "ts_ls", "tailwindcss", "eslint" }

local function setupServers()
  for _, llsp in ipairs(servers) do
    -- lspconfig[llsp].setup({
    lspconfig.setupServer(tostring(llsp), {
      capabilities = capabilities,
      on_attach = function(client, bufnr)
        print("Hello Javascript/Typescript")
      end,
    })
  end
end

return {
  setupServers(),
}
