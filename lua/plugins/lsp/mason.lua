return {
  {
    "williamboman/mason.nvim",
    dependencies = {
      {
        "williamboman/mason-lspconfig.nvim",
        dependencies = {
          "Hoffs/omnisharp-extended-lsp.nvim",
          "neovim/nvim-lspconfig",
        },
      },
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      -- {
      --   "jay-babu/mason-null-ls.nvim",
      --   event = { "BufReadPre", "BufNewFile" },
      -- },
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
        -- auto-install configured servers (with lspconfig)
        -- automatic_installation = true, -- not the same as ensure_installed

        ui = {
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
          },
        },
      })

      mason_lspconfig.setup()

      -- local mason_null_ls = require("mason-null-ls")
      --
      -- mason_null_ls.setup()

      masontools.setup({
        ensure_installed = {
          -- BASH
          "bash-language-server", -- LSP
          -- "bash-debug-adapter", -- DAP
          "shellharden", -- formatter and linter
          -- C/C++
          -- 'cpptools', -- DAP
          "clangd", -- LSP and linter
          -- "ccls", -- Used for Codelens
          -- "codelldb", -- DAP
          "clang-format", -- formatter
          -- "cpplint", -- linter - DEPRECATED, use clangd
          -- CSHARP
          "csharp-language-server", -- LSP
          "omnisharp", -- LSP
          "omnisharp-mono", -- LSP
          "csharpier", -- Formatter
          -- CMAKE
          "cmake-language-server", -- LSP
          "cmakelang", -- formatter and linter
          -- GOLANG
          -- "gopls", -- LSP
          -- GODOT SCRIPT
          -- "gdscript", -- LSP
          "gdtoolkit", -- formatter and linter
          -- JavaScript/TypeScript
          "typescript-language-server", -- LSP
          "tailwindcss-language-server", -- Autocomplete
          "eslint-lsp", -- Linter
          -- JSON
          "biome", -- formatter and linter
          "jsonls", -- LSP
          -- LUA
          "lua-language-server", -- LSP
          "stylua", -- formatter and linter
          -- -- RUST cpptools and ast-grep
          -- "rust_analyzer", -- LSP
          -- -- SQL
          -- "sqlls", -- LSP
          -- "sql-formatter", -- formatter
          -- "sqlfluff", -- linter
          -- -- YAML
          -- "yaml-language-server", -- LSP
          -- "yamllint", -- linter
          -- GLOBAL (Not really)
          "prettierd", -- formatter
        },
        automatic_installation = true,
        auto_update = true,
        run_on_start = true,
        start_delay = 1500, -- Millisseconds
      })
    end,
  },
}
