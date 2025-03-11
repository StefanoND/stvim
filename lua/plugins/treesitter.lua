return {
  {
    "Badhi/nvim-treesitter-cpp-tools",
    dependencies = "nvim-treesitter/nvim-treesitter",
    opts = function()
      local options = {
        preview = {
          quit = "q", -- optional keymapping for quit preview
          accept = "<tab>", -- optional keymapping for accept preview
        },
        header_extension = "h", -- optional
        source_extension = "cpp", -- optional
        custom_define_class_function_commands = { -- optional
          TSCppImplWrite = {
            output_handle = require("nt-cpp-tools.output_handlers").get_add_to_cpp(),
          },
          --[[
                <your impl function custom command name> = {
                    output_handle = function (str, context)
                        -- string contains the class implementation
                        -- do whatever you want to do with it
                    end
                }
                ]]
        },
      }
      return options
    end,
    -- End configuration
    config = true,
  },
  { -- parser
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    event = { "BufReadPre", "BufNewFile" },
    build = ":TSUpdate",
    dependencies = {
      "windwp/nvim-ts-autotag",
    },
    config = function()
      -- Windows: https://code.visualstudio.com/docs/cpp/config-mingw
      -- Follow the steps 1-7 of "Installing the MingGW-w64 toolchain"
      -- Before running "pacman -S --needed ...." run "pacman -Syu" first
      -- Choose the "mingw-w64-ucrt-x86_64-gcc" as of this writting, it is number 3 (Three)

      -- local treesitter = require("nvim-treesitter.configs")

      local config = function(_)
        require("nvim-treesitter.configs").setup({
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
            "gdscript",
            "git_config",
            "git_rebase",
            "gitattributes",
            "gitcommit",
            "gitignore",
            "go",
            "godot_resource",
            "html",
            "javascript",
            "json",
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

          -- Install parsers synchronously (only applied to `ensure_installed`)
          sync_install = false,

          -- Automatically install missing parsers when entering buffer
          -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
          auto_install = true,

          -- autotagging from nvim-ts-autotag plugin
          -- autotag = {
          --   enable = true,
          -- },

          indent = {
            enable = true,
          },

          -- Syntax highlighting
          highlight = {
            enable = true,
            -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
            -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
            -- Using this option may slow down your editor, and you may see some duplicate highlights.
            -- Instead of true it can also be a list of languages
            additional_vim_regex_highlighting = false,
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
        })
      end

      config()

      -- treesitter.setup({
      -- })

      vim.opt.foldmethod = "expr"
      vim.opt.foldexpr = "nvim_treesitter#foldexpr()"

      require("ts_context_commentstring").setup()

      require("ufo").setup({
        provider_selector = function(bufnr, filetype, buftype)
          return { "treesitter", "indent" }
        end,
      })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    config = function()
      require("treesitter-context").setup({
        enable = true,
      })
    end,
  },
  {
    "windwp/nvim-ts-autotag",
    config = function()
      require("nvim-ts-autotag").setup({
        opts = {
          -- Defaults
          enable_close = true, -- Auto close tags
          enable_rename = true, -- Auto rename pairs of tags
          enable_close_on_slash = false, -- Auto close on trailing </
        },
        -- Also override individual filetype configs, these take priority.
        -- Empty by default, useful if one of the "opts" global settings
        -- doesn't work well in a specific filetype
        per_filetype = {
          ["html"] = {
            enable_close = false,
          },
        },
      })
    end,
  },
}
