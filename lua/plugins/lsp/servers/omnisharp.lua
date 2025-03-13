local lspconfig = require("lspconfig")
local lspSetup = require("config.lsp.setup")
local capabilities = require("config.lsp.capabilities").capabilities
local util = require("lspconfig.util")

local pid = vim.fn.getpid()

-- Must be version 1.39.8, versions 1.39.9 - 1.39.11 (latest as of this writing) are causing issues:
--     "Error executing luv callback... Attempt to Index Local 'decoded' (a nil value)..."
-- Will update when this gets fixed (and if I remember)
local omnisharp_bin

if vim.fn.has("win64") == 1 or vim.fn.has("win32") == 1 or vim.fn.has("win16") == 1 then
  -- lspconfig.powershell_es.setup({
  lspSetup.setupServer("powershell_es", {
    bundle_path = "path/to/your/bundle_path",
    init_options = {
      enableProfileLoading = false,
    },
  })
  omnisharp_bin = os.getenv("UserProfile")
    .. "/AppData/Local/nvim/Utilities/omnisharp-mono_1.39.8/OmniSharp.exe"
  vim.g.OmniSharp_server_use_mono = true
else -- I don't own/use a Mac, will update when/if I do
  -- omnisharp_bin = os.getenv("HOME") .. "/.config/nvim/Utilities/omnisharp-linux-x64_1.39.8/run"
  omnisharp_bin = os.getenv("HOME")
    -- .. "/.local/share/nvim/mason/packages/omnisharp/omnisharp"
    .. "/.config/nvim/Utilities/omnisharp-linux-x64-net6.0_1.39.8/OmniSharp"
  -- .. "/.config/nvim/Utilities/omnisharp-linux-x64-net6.0_1.39.11/OmniSharp"
end

vim.g.OmniSharp_server_stdio = 1

lspconfig.omnisharp.enableImportCompletion = true

return {
  -- lspconfig.omnisharp.setup({
  lspSetup.setupServer("omnisharp", {
    capabilities = capabilities,
    use_mono = true,
    default_config = {
      filetypes = { "cs", "vb" },
      root_dir = function(fname)
        return util.root_pattern("*.sln")(fname) or util.root_pattern("*.csproj")(fname)
      end,
      on_new_config = function(new_config, new_root_dir)
        if new_root_dir then
          table.insert(new_config.cmd, "-s")
          table.insert(new_config.cmd, new_root_dir)
        end
      end,
      init_options = {},
    },
    settings = {
      FormattingOptions = {
        -- Enables support for reading code style, naming convention and analyzer
        -- settings from .editorconfig.
        EnableEditorConfigSupport = true,
        -- Specifies whether 'using' directives should be grouped and sorted during
        -- document formatting.
        OrganizeImports = true,
      },
      MsBuild = {
        -- If true, MSBuild project system will only load projects for files that
        -- were opened in the editor. This setting is useful for big C# codebases
        -- and allows for faster initialization of code navigation features only
        -- for projects that are relevant to code that is being edited. With this
        -- setting enabled OmniSharp may load fewer projects and may thus display
        -- incomplete reference lists for symbols.
        LoadProjectsOnDemand = nil,
      },
      RoslynExtensionsOptions = {
        -- Enables support for roslyn analyzers, code fixes and rulesets.
        EnableAnalyzersSupport = true,
        -- Enables support for showing unimported types and unimported extension
        -- methods in completion lists. When committed, the appropriate using
        -- directive will be added at the top of the current file. This option can
        -- have a negative impact on initial completion responsiveness,
        -- particularly for the first few completion sessions after opening a
        -- solution.
        EnableImportCompletion = true,
        -- Only run analyzers against open files when 'enableRoslynAnalyzers' is
        -- true
        AnalyzeOpenDocumentsOnly = nil,
      },
      Sdk = {
        -- Specifies whether to include preview versions of the .NET SDK when
        -- determining which version to use for project loading.
        IncludePrereleases = nil,
      },
    },
    flags = {
      debounce_text_changes = 150,
    },
    cmd = { omnisharp_bin, "--languageserver", "--hostPID", tostring(pid) },
    -- cmd = vim.lsp.rpc.connect("127.0.0.1", 6007),
    -- cmd = { omnisharp_bin },
    on_attach = function(client, bufnr)
      require("lsp_signature").on_attach({
        bind = true,
        handler_opts = {
          border = "rounded",
        },
      }, bufnr)
      local opts = { buffer = bufnr, noremap = true, remap = false }
      -- vim.keymap.set(
      --   "n",
      --   "gd",
      --   "<cmd>lua require('omnisharp_extended').telescope_lsp_definitions()<CR>",
      --   opts
      -- )

      -- Only request omnisharp for formatting or other installed formatters
      -- that supports C# will also format it.
      -- set({ "n", "x" }, "<leader>cf", function()
      --   vim.lsp.buf.format({
      --     filter = function(client)
      --       return client.name == "omnisharp"
      --     end,
      --     async = true,
      --     timeout_ms = 10000,
      --   })
      -- end, opts)

      vim.opt.wrap = false

      -- "Hacky, non-future-proof fix" - Arocci, Nicolai
      client.server_capabilities.semanticTokensProvider = {
        full = vim.empty_dict(),
        legend = {
          tokenModifiers = { "static_symbol" },
          tokenTypes = {
            "comment",
            "excluded_code",
            "identifier",
            "keyword",
            "keyword_control",
            "number",
            "operator",
            "operator_overloaded",
            "preprocessor_keyword",
            "string",
            "whitespace",
            "text",
            "static_symbol",
            "preprocessor_text",
            "punctuation",
            "string_verbatim",
            "string_escape_character",
            "class_name",
            "delegate_name",
            "enum_name",
            "interface_name",
            "module_name",
            "struct_name",
            "type_parameter_name",
            "field_name",
            "enum_member_name",
            "constant_name",
            "local_name",
            "parameter_name",
            "method_name",
            "extension_method_name",
            "property_name",
            "event_name",
            "namespace_name",
            "label_name",
            "xml_doc_comment_attribute_name",
            "xml_doc_comment_attribute_quotes",
            "xml_doc_comment_attribute_value",
            "xml_doc_comment_cdata_section",
            "xml_doc_comment_comment",
            "xml_doc_comment_delimiter",
            "xml_doc_comment_entity_reference",
            "xml_doc_comment_name",
            "xml_doc_comment_processing_instruction",
            "xml_doc_comment_text",
            "xml_literal_attribute_name",
            "xml_literal_attribute_quotes",
            "xml_literal_attribute_value",
            "xml_literal_cdata_section",
            "xml_literal_comment",
            "xml_literal_delimiter",
            "xml_literal_embedded_expression",
            "xml_literal_entity_reference",
            "xml_literal_name",
            "xml_literal_processing_instruction",
            "xml_literal_text",
            "regex_comment",
            "regex_character_class",
            "regex_anchor",
            "regex_quantifier",
            "regex_grouping",
            "regex_alternation",
            "regex_text",
            "regex_self_escaped_character",
            "regex_other_escape",
          },
        },
        range = true,
      }

      print("Hello Omnisharp")
    end,
  }),
}
