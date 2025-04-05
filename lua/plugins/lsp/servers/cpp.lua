local lspconfig = require("config.lsp.setup")
local capabilities = require("config.lsp.capabilities").capabilities
local funcs = require("config.functions")

local clangd_ext_opts = require("clangd_extensions").opts

clangd_ext_opts = {
  inlay_hints = {
    inline = false,
  },
  ast = {
    --These require codicons (https://github.com/microsoft/vscode-codicons)
    role_icons = {
      type = "",
      declaration = "",
      expression = "",
      specifier = "",
      statement = "",
      ["template argument"] = "",
    },
    kind_icons = {
      Compound = "",
      Recovery = "",
      TranslationUnit = "",
      PackExpansion = "",
      TemplateTypeParm = "",
      TemplateTemplateParm = "",
      TemplateParamObject = "",
    },
  },
}

return {
  -- lspconfig.ccls.setup({ cclsConf }),
  require("ccls").setup({
    lsp = {
      -- server = {
      lspconfig = {
        filetypes = { "c", "cc", "cpp", "objc", "objcpp", "opencl" },
        disabled_filetypes = { "nss", "nwscript", "cs", "csharp" }, -- Don't want it messing with C#
        flags = { allow_incremental_sync = true },
        init_options = {
          compilationDatabaseDirectory = "build",
          cache = {
            directory = vim.fs.normalize("~/.cache/ccls/"),
          },
          index = { threads = 2 },
          clang = { excludeArgs = { "-frounding-math" } },
        },
        name = "ccls",
        cmd = { "ccls" },
        offset_encoding = "utf-32",
        root_dir = function(fname)
          return require("lspconfig.util").root_pattern(
            ".null-ls-root",
            "Makefile",
            "CMakefile",
            ".git",
            ".sln",
            "package.json",
            "project.godot",
            "configure.ac",
            "configure.in",
            "config.h.in",
            "meson.build",
            "meson_options.txt",
            "build.ninja",
            "compile_commands.json",
            "compile_flags.txt",
            ".uproject"
          )(fname) or require("lspconfig.util").find_git_ancestor(fname)
        end,
      },
      filetypes = { "c", "cc", "cpp", "objc", "objcpp", "opencl" },
      disabled_filetypes = { "cmake", "nss", "nwscript", "cs", "csharp" }, -- Don't want it messing with C#
      disable_capabilities = {
        completionProvider = true,
        documentFormattingProvider = true,
        documentRangeFormattingProvider = true,
        documentHighlightProvider = true,
        documentSymbolProvider = true,
        workspaceSymbolProvider = true,
        renameProvider = true,
        hoverProvider = true,
        codeActionProvider = true,
      },
      disable_diagnostics = true,
      disable_signature = true,
      codelens = {
        enable = true,
        events = { "BufWritePost", "BufEnter", "CursorHold", "InsertLeave", "TextChanged" },
      },
    },
  }),
  lspconfig.setupServer("clangd", {
    capabilities = capabilities,
    opts = require("clangd_extensions").setup(clangd_ext_opts or {}),
    cmd = {
      "clangd",
      -- "--offsetEncoding=utf-16",
      "--background-index",
      "--clang-tidy",
      "--suggest-missing-includes",
      "--header-insertion=iwyu",
      "--completion-style=detailed",
      "--function-arg-placeholders",
      "--fallback-style=microsoft",
    },
    flags = { allow_incremental_sync = true, debounce_text_changes = 500 },
    default_config = {
      flags = { allow_incremental_sync = true, debounce_text_changes = 500 },
      filetypes = { "c", "cc", "cpp", "objc", "objcpp", "opencl" },
      disabled_filetypes = { "cmake", "nss", "nwscript", "cs", "csharp" }, -- Don't want it messing with C#
      root_dir = funcs.getRoot(),
      init_options = {
        usePlaceholders = true,
        completeUnimported = true,
        clangdFileStatus = true,
      },
    },
    on_attach = function(client, bufnr)
      require("config.keymaps.languages.cpp")

      local path = vim.fn.getcwd()
      if vim.fn.filereadable(path .. "/" .. vim.fn.fnamemodify(path, ":t") .. ".uproject") then
        require("config.keymaps.languages.unreal")
      end
      print("Hello C/C++")
    end,
  }),
}
