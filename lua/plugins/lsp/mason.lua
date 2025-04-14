return {
  {
    "jay-babu/mason-nvim-dap.nvim",
    dependencies = { "williamboman/mason.nvim" },
    version = false,
    config = function()
      require("mason-nvim-dap").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    version = false,
    config = function()
      require("mason-lspconfig").setup()
    end,
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = { "williamboman/mason.nvim" },
    version = false,
    opts = function()
      return {
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
          -- "tailwindcss-language-server", -- Autocomplete
          "js-debug-adapter", -- DAP
          -- JSON
          "jsonls", -- LSP
          -- LUA
          "lua-language-server", -- LSP
          "stylua", -- formatter and linter
          -- MARKDOWN
          "marksman",
          "markdownlint-cli2", -- Linter
          "markdown-toc", -- TOC Formatter
          -- RUST ast-grep
          "rust_analyzer", -- LSP
          -- SQL
          "sqlls", -- LSP
          "sql-formatter", -- formatter
          "sqlfluff", -- linter
          -- YAML
          "yaml-language-server", -- LSP
          "yamllint", -- linter
          -- GLOBAL
          "biome", -- formatter and linter - JS/TS, Json
          "prettier", -- formatter - Markdown
        },
        automatic_installation = true,
        auto_update = true,
        run_on_start = true,
        start_delay = 1500, -- Millisseconds
      }
    end,
    config = function(_, opts)
      require("mason-tool-installer").setup(opts)
    end,
  },
  {
    "williamboman/mason.nvim",
    version = false,
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
    opts = function()
      return {
        ui = {
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
          },
        },
      }
    end,
    config = function(_, opts)
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

      require("mason").setup(opts)
    end,
  },
}
