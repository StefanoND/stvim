local lspSetup = require("config.lsp.setup")

local pid = vim.fn.getpid()

return {
  lspSetup.setupServer("omnisharp", {
    handlers = {
      ["textDocument/definition"] = function(...)
        return require("omnisharp_extended").handler(...)
      end,
    },
    keys = require("config.keymaps.languages.c_sharp"),
    filetypes = { "cs", "fsharp", "vb" },
    settings = {
      FormattingOptions = {
        EnableEditorConfigSupport = true, -- .editorconfig support.
        OrganizeImports = true, -- "using" directives are grouped and sorted when formatting document.
      },
      RoslynExtensionsOptions = {
        EnableAnalyzersSupport = true, -- support for roslyn analyzers, code fixes and rulesets.
        EnableImportCompletion = true, -- Adds completion support for unimported types/extension methods
      },
    },
    cmd = { "omnisharp", "-lsp", "--hostPID", tostring(pid) },
    on_attach = function(client, bufnr)
      vim.g.OmniSharp_server_stdio = 1
      -- require("config.keymaps.languages.c_sharp")
      print("Hello Omnisharp")
    end,
  }),
}
