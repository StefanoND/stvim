local lspconfig = require("config.lsp.setup")
local capabilities = require("config.lsp.capabilities").capabilities

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

local cppFuncs = function(client, bufnr)
  local opts = { buffer = bufnr, noremap = true, remap = false }
  local keymap = vim.keymap.set
  local extend = function(desc)
    return vim.tbl_deep_extend("force", opts, { desc = desc })
  end

  keymap("n", "<leader>cR", "<cmd>ClangdSwitchSourceHeader<cr>", extend("Switch Source/Header (C/C++)"))

  -- switch between header and source file
  keymap("n", "<M-o>", function()
    local filename = vim.fn.expand("%:p")
    local new_filename

    if string.match(filename, ".h$") then
      new_filename = string.gsub(filename, ".h$", ".cpp")
    elseif string.match(filename, ".cpp$") then
      new_filename = string.gsub(filename, ".cpp$", ".h")
    end

    if new_filename then
      vim.cmd("e " .. new_filename)
    end
  end, extend("Switch Source/Header (C/C++)"))
end

local unrealFuncs = function(client, bufnr)
  local opts = { buffer = bufnr, noremap = true, remap = false }
  local km = function(key, cmd, opt)
    vim.keymap.set("n", key, cmd, opt)
  end
  local ext = function(desc)
    return vim.tbl_deep_extend("force", opts, { desc = desc })
  end
  local t = ":terminal ue "

  -- run [--debug] [EXTRA ARGS] - Run the editor for the Unreal project
  km("<leader>uer", t .. "run<CR>", ext("Run the editor"))

  -- gen [EXTRA ARGS] - Generate IDE project files for the Unreal project
  km("<leader>ueg", t .. "gen<CR>", ext("Generate IDE project files"))

  -- build [CONFIGURATION] [TARGET] - Build the Editor modules for the Unreal project or plugin
  km("<leader>ueb", t .. "build<CR>", ext("Build the Editor modules for Project or Plugin"))

  -- clean - Clean build artifacts for the Unreal project or plugin
  km("<leader>uec", t .. "clean<CR>", ext("Clean build artifacts for project or plugin"))

  -- test [--withrhi] [--list] [--all] [--filter FILTER] TEST1 TEST2 TESTN [-- EXTRA ARGS]
  -- Run automation tests for the Unreal project
  km("<leader>uet", t .. "test<CR>", ext("Run automation tests"))

  -- package [PROJECT CONFIGURATION] [EXTRA UAT ARGS] - Package a build of the Unreal project or plugin
  -- in the current directory, storing the result in a subdirectory named "dist".
  -- Default configuration for projects is Shipping.
  km("<leader>uep", t .. "package<CR>", ext("Package a build of the project or plugin"))
end

return {
  -- lspconfig.ccls.setup({ cclsConf }),
  require("ccls").setup({
    lsp = {
      -- server = {
      lspconfig = {
        filetypes = { "c", "cpp", "objc", "objcpp", "opencl" },
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
      filetypes = { "c", "cpp", "objc", "objcpp", "opencl" },
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
    -- require("clangd_extensions").setup(vim.tbl_deep_extend("force", clangd_ext_opts or {}, {
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
      filetypes = { "c", "cpp", "objc", "objcpp", "opencl" },
      disabled_filetypes = { "cmake", "nss", "nwscript", "cs", "csharp" }, -- Don't want it messing with C#
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
      init_options = {
        usePlaceholders = true,
        completeUnimported = true,
        clangdFileStatus = true,
      },
    },
    on_attach = function(client, bufnr)
      cppFuncs(client, bufnr)

      local path = vim.fn.getcwd()
      if vim.fn.filereadable(path .. "/" .. vim.fn.fnamemodify(path, ":t") .. ".uproject") then
        unrealFuncs(client, bufnr)
      end

      client.resolved_capabilities.document_formatting = true

      vim.opt.tabstop = 4
      vim.opt.softtabstop = 4
      vim.opt.shiftwidth = 4

      print("Hello C/C++")
    end,
  }),
}
