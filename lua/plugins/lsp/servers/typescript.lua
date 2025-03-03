local lsp = require("lsp-zero")
lsp.extend_lspconfig()

lsp.setup()

local lspconfig = require("lspconfig")

local handlers = {
  ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" }),
  ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" }),
}

local lsp_defaults = lspconfig.util.default_config
local cmpcapabilities =
  require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

cmpcapabilities.textDocument.completion.completionItem.snippetSupport = true
cmpcapabilities.textDocument.foldingRange = {
  dynamicRegistration = false,
  lineFoldingOnly = true,
}

local capabilities = vim.tbl_deep_extend("force", lsp_defaults.capabilities, {
  cmpcapabilities,
})

local servers = { "ts_ls", "tailwindcss", "eslint" }

local function setupServers()
  for _, llsp in ipairs(servers) do
    lspconfig[llsp].setup({
      capabilities = capabilities,
      handlers = handlers,
      on_attach = function(client, bufnr)
        print("Hello Javascript/Typescript")
      end,
    })
  end
end

return {
  setupServers(),
}
