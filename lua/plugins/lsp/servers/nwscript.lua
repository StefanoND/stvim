local lspconfig = require("config.lsp.setup")
local capabilities = require("config.lsp.capabilities").capabilities
local funcs = require("config.functions")

return {
  lspconfig.setupServer("nwscript_ls", {
    flags = { allow_incremental_sync = true, debounce_text_changes = 500 },
    capabilities = capabilities,
    on_attach = function(client, bufnr)
      print("Hello NWScript")
    end,
    settings = {
      single_file_support = true,
      ["nwscript-ee-lsp"] = {
        completion = {
          addParamsToFunctions = true,
        },
        hovering = {
          addCommentsToFunctions = true,
        },
        formatter = {
          enabled = true,
          verbose = true,
          executable = "clang-format",
        },
        compiler = {
          enabled = true,
          os = funcs.getOS(),
          verbose = true,
          reportWarnings = true,
          nwnHome = os.getenv("NWN_HOME"),
          nwnInstallation = os.getenv("NWN_ROOT"),
          workspaceIncludes = { vim.fn.getcwd() },
        },
      },
    },
  }),
}
