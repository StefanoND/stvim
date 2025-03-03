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

return {
  lspconfig.gdscript.setup({
    capabilities = capabilities,
    handlers = handlers,
    -- cmd = vim.lsp.rpc.connect("127.0.0.1", 6007),
    on_attach = function(client, bufnr)
      vim.opt.tabstop = 4
      vim.opt.softtabstop = 4
      vim.opt.shiftwidth = 4
      vim.opt.expandtab = false -- Don't expand tab to spaces
      vim.opt.smartindent = true
      vim.opt.autoindent = true -- Copy indent from current line when starting a new one
      print("Hello Godot")
    end,
  }),
}
