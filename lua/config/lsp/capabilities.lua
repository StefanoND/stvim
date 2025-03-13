local M = {}

M.encoding = { offsetEncoding = { "utf-8", "utf-16", "utf-32" } }

M.workspace = {
  configuration = true,
  didChangeConfiguration = { dynamicRegistration = true },
  didChangeWorkspaceFolders = { dynamicRegistration = true },
  didChangeWatchedFiles = {
    dynamicRegistration = true,
    -- TODO(lewis6991): do not advertise didChangeWatchedFiles on Linux
    -- or BSD since all the current backends are too limited.
    -- Ref: #27807, #28058, #23291, #26520
    relativePatternSupport = false,
  },
}

M.textDocument = {
  completion = { completionItem = { snippetSupport = true } },
  foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true,
  },
}

M.lspCapabilities = require("lspconfig.util").default_config.capabilities
-- M.cmpCapabilities = require("cmp_nvim_lsp").default_capabilities()
-- M.allCapabilities = vim.tbl_deep_extend("force", M.lspCapabilities, M.cmpCapabilities, M.encoding)
M.allCapabilities = vim.tbl_deep_extend("force", M.lspCapabilities, M.encoding)

M.allCapabilities.workspace = M.workspace
M.allCapabilities.textDocument = M.textDocument

M.capabilities = require("blink.cmp").get_lsp_capabilities(M.allCapabilities)

return M
