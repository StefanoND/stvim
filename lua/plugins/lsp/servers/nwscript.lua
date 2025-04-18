local lspconfig = require("config.lsp.setup")
local funcs = require("config.functions")

return {
  lspconfig.setupServer("nwscript_ls", {
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
          nwnHome = function()
            if os.getenv("NWN_HOME") ~= "v:null" then
              return os.getenv("NWN_HOME")
            end
            return ""
          end,
          nwnInstallation = function()
            if os.getenv("NWN_ROOT") ~= "v:null" then
              return os.getenv("NWN_ROOT")
            end
            return ""
          end,
          workspaceIncludes = { vim.fn.getcwd() },
        },
      },
    },
  }),
}
