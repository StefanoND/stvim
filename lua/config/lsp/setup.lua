local M = {}

M.onAttach = function(client, bufnr)
  -- require("lsp_signature").on_attach({
  --   bind = true,
  --   handler_opts = {
  --     border = "rounded",
  --   },
  -- }, bufnr)
end

M.setupServer = function(name, args)
  args = args or {}
  name = name or ""
  assert(type(name) == "string", "Expected a string value")

  local lspconfig = require("lspconfig")

  local opts = {
    on_attach = M.onAttach,
  }

  if args then
    opts = vim.tbl_extend("force", opts, args)
  end

  lspconfig[name].setup(opts)
end

return M
