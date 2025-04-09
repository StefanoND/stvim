return {
  { "jay-babu/mason-nvim-dap.nvim", config = function() end },
  { "williamboman/mason-lspconfig.nvim", config = function() end },
  {
    "williamboman/mason.nvim",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      "jay-babu/mason-nvim-dap.nvim",
    },
    lazy = false,
    cmd = {
      "Mason",
      "MasonInstall",
      "MasonInstallAll",
      "MasonUninstall",
      "MasonUninstallAll",
      "MasonLog",
    },
    build = ":MasonUpdate",
    config = function()
      local mason = require("mason")
      local mason_lspconfig = require("mason-lspconfig")
      local masontools = require("mason-tool-installer")

      vim.api.nvim_create_autocmd("User", {
        pattern = "MasonToolsStartingInstall",
        callback = function()
          vim.schedule(function()
            print("mason-tool-installer is starting")
          end)
        end,
      })

      vim.api.nvim_create_autocmd("User", {
        pattern = "MasonToolsUpdateCompleted",
        callback = function(e)
          vim.schedule(function()
            print(vim.inspect(e.data)) -- print the table that lists the programs that were installed
          end)
        end,
      })

      mason.setup({
        ui = {
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
          },
        },
      })

      mason_lspconfig.setup()

      masontools.setup({
        ensure_installed = {
          -- BASH
          "bash-language-server", -- LSP
          "bash-debug-adapter", -- DAP
          "shellharden", -- formatter and linter
          -- C/C++
          "clangd", -- LSP and linter
          "codelldb", -- DAP (lldb)
          "clang-format", -- formatter
          -- CSHARP
          "csharp-language-server", -- LSP
          "omnisharp", -- LSP
          "omnisharp-mono", -- LSP
          "csharpier", -- Formatter
          "netcoredbg",
          -- CMAKE
          "cmakelang", -- LSP
          "cmakelint", -- formatter and linter
          -- GOLANG
          -- "gopls", -- LSP
          -- GODOT SCRIPT
          -- "gdscript", -- LSP
          -- "gdformat", -- formatter
          "gdtoolkit", -- formatter and linter
          -- JavaScript/TypeScript
          "typescript-language-server", -- LSP
          "vtsls", -- LSP
          "tailwindcss-language-server", -- Autocomplete
          "js-debug-adapter", -- DAP
          -- JSON
          "jsonls", -- LSP
          -- LUA
          "lua-language-server", -- LSP
          "stylua", -- formatter and linter
          -- MARKDOWN
          "marksman",
          "markdownlint-cli2", -- Linter
          "markdown-toc",
          -- RUST ast-grep
          "rust_analyzer", -- LSP
          -- SQL
          "sqlls", -- LSP
          "sql-formatter", -- formatter
          "sqlfluff", -- linter
          -- YAML
          "yaml-language-server", -- LSP
          "yamllint", -- linter
          -- GLOBAL (JS/TS, md, json)
          "biome", -- formatter and linter
        },
        automatic_installation = true,
        auto_update = true,
        run_on_start = true,
        start_delay = 1500, -- Millisseconds
      })
    end,
  },
}
