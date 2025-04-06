return {
  -- {
  --   "nvim-treesitter/nvim-treesitter-context",
  --   config = function()
  --     require("treesitter-context").setup({
  --       enable = true,
  --     })
  --   end,
  -- },
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    event = { "BufReadPre", "BufNewFile" },
    build = ":TSUpdate",
    -- dependencies = {
    --   "JoosepAlviste/nvim-ts-context-commentstring",
    -- },
    opts = {
      -- A list of parser names, or "all" (the five listed parsers should always be installed)
      ensure_installed = {
        -- "maintained",
        "bash",
        "c",
        "c_sharp",
        "cmake",
        "comment",
        "cpp",
        "css",
        "fish",
        "gdscript",
        "git_config",
        "git_rebase",
        "gitattributes",
        "gitcommit",
        "gitignore",
        "go",
        "godot_resource",
        "html",
        "ini",
        "javascript",
        "json",
        "latex",
        "llvm",
        "lua",
        "make",
        "markdown",
        "markdown_inline",
        "norg",
        "query",
        "regex",
        "rust",
        "sql",
        "tsx",
        "typescript",
        "vim",
        "vimdoc",
        "yaml",
      },
      -- ignore_install = { "org" }, -- orgmode.nvim. Only required if ensure_instaleld = "all"

      -- Install parsers synchronously (only applied to `ensure_installed`)
      sync_install = false,
      auto_install = true,

      indent = {
        enable = true,
      },

      -- Syntax highlighting
      highlight = {
        enable = true,
        -- additional_vim_regex_highlighting = false,
        additional_vim_regex_highlighting = { "markdown" },
      },

      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-space>",
          node_incremental = "<C-space>",
          scope_incremental = false,
          node_decremental = "<bs>",
        },
      },
      textobjects = {
        select = {
          enable = false,
        },
      },
    },
    config = function(_, opts)
      local vars = require("config.vars")
      local maxSize = vars.maxFileSize
      local size = vim.fn.getfsize(vim.fn.expand("%"))
      if size >= maxSize then
        local clients = vim.lsp.get_clients()
        for _, lclient in ipairs(clients) do
          vim.lsp.stop_client(lclient)
        end
        return
      end

      -- Windows: https://code.visualstudio.com/docs/cpp/config-mingw
      -- Follow the steps 1-7 of "Installing the MingGW-w64 toolchain"
      -- Before running "pacman -S --needed ...." run "pacman -Syu" first
      -- Choose the "mingw-w64-ucrt-x86_64-gcc" as of this writting, it is number 3 (Three)

      require("nvim-treesitter.configs").setup(opts)

      vim.opt.foldmethod = "expr"
      vim.opt.foldexpr = "nvim_treesitter#foldexpr()"

      -- require("ts_context_commentstring").setup()
    end,
  },
}
